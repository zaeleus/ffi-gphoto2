module GPhoto2
  class CameraFile
    include FFI::GPhoto2
    include GPhoto2::Struct

    attr_reader :folder, :name

    def initialize(camera, folder = nil, name = nil)
      @camera = camera
      @folder, @name = folder, name
      new
    end

    def preview?
      @folder.nil? && @name.nil?
    end

    def save(pathname = default_filename)
      File.binwrite(pathname, data)
    end

    def delete
      @camera.delete(self)
    end

    def data
      data_and_size.first
    end

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
      # previews are always jpg
      preview? ? 'capture_preview.jpg' : @name
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
