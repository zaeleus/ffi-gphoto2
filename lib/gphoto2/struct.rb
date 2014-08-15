module GPhoto2
  module Struct
    # @return [FFI::Struct]
    attr_reader :ptr

    # @return [FFI::Struct]
    def to_ptr
      ptr
    end
  end
end
