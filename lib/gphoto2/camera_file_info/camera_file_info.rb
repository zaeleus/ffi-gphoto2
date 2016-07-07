module GPhoto2
  # @abstract
  class CameraFileInfo
    include FFI::GPhoto2
    include GPhoto2::Struct

    # @param [FFI::GPhoto2::CameraFileInfo] ptr
    def initialize(ptr)
      @ptr = ptr
    end

    # @return [Integer] a bit field of set info fields
    def fields
      fields = ptr[:fields]

      if fields.is_a?(Symbol)
        CameraFileInfoFields[fields]
      else
        fields
      end
    end

    # return [Boolean] whether the given field is set
    def has_field?(field)
      (fields & CameraFileInfoFields[field]) != 0
    end

    # @return [CameraFileStatus, nil]
    def status
      fetch(:status)
    end

    # @return [Integer, nil] the size of the file in bytes
    def size
      fetch(:size)
    end

    # @return [String, nil] the media type of the file
    def type
      type = fetch(:type)
      type ? type.to_s : nil
    end

    protected

    # param [Symbol] key
    # @return [Object, nil]
    def fetch(key)
      ptr[key] if has_field?(key)
    end
  end
end
