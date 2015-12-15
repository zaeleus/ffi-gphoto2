module GPhoto2
  class CameraFile
    include FFI::GPhoto2
    include GPhoto2::Struct

    # The preview data is assumed to be a jpg.
    PREVIEW_FILENAME = 'capture_preview.jpg'.freeze

    # @return [String]
    attr_reader :folder

    # @return [String]
    attr_reader :name

    # @param [GPhoto2::Camera] camera
    # @param [String] folder
    # @param [String] name
    def initialize(camera, folder = nil, name = nil)
      @camera = camera
      @folder, @name = folder, name
      new
    end

    # @return [Boolean]
    def preview?
      @folder.nil? && @name.nil?
    end

    # @param [String] pathname
    # @return [Integer] the number of bytes written
    def save(pathname = default_filename)
      File.binwrite(pathname, data)
    end

    # @return [void]
    def delete
      @camera.delete(self)
    end

    # @return [String]
    def data
      data_and_size.first
    end

    # @return [Integer]
    def size
      data_and_size.last
    end

    private

    def data_and_size
      @data_and_size ||= begin
        @camera.file(self) unless preview?
        get_data_and_size
      end
    end

    def default_filename
      preview? ? CAPTURE_FILENAME : @name
    end

    def new
      ptr = FFI::MemoryPointer.new(FFI::GPhoto2::CameraFile)
      rc = gp_file_new(ptr)
      GPhoto2.check!(rc)
      @ptr = FFI::GPhoto2::CameraFile.new(ptr.read_pointer)
    end

    def get_data_and_size
      data = FFI::MemoryPointer.new(:uchar)
      data_ptr = FFI::MemoryPointer.new(:pointer)
      data_ptr.write_pointer(data)
      size = FFI::MemoryPointer.new(:ulong)

      rc = gp_file_get_data_and_size(ptr, data_ptr, size)
      GPhoto2.check!(rc)

      size = size.read_ulong
      data = data_ptr.read_pointer.read_bytes(size)

      [data, size]
    end
  end
end
