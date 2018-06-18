module GPhoto2
  class Error < RuntimeError

    # @return [Integer]
    attr_reader :code

    # int port_result => ClassName
    ERROR_MAP = {}

    # Map additional libgphoto2 errors
    FFI::GPhoto2::Result.all.each do |port_result, constant|
      ERROR_MAP[port_result] = self.const_set(constant, Class.new(self)) if port_result < 0 # skip GP_OK
    end

    def self.error_from_port_result(rc)
      error_klass = ERROR_MAP[rc] || self
      error_klass.new(PortResult.as_string(rc), rc)
    end



    # @param [String] message
    # @param [Integer] code
    def initialize(message, code)
      super(message)
      @code = code
    end

    # @return [String]
    def to_s
      "#{super} (#{code})"
    end
  end
end
