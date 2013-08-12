module GPhoto2
  class CameraFile
    include FFI::GPhoto2

    attr_reader :ptr

    def initialize(camera, camera_file_path)
      @camera = camera
      @camera_file_path = camera_file_path
      new
    end

    def finalize
      free
    end

    def save(pathname = nil)
      data = get_data_and_size.first
      pathname ||= @camera_file_path.name
      File.binwrite(pathname, data)
    end

    def to_ptr
      @ptr
    end

    private

    def new
      ptr = FFI::MemoryPointer.new(FFI::GPhoto2::CameraFile)
      rc = gp_file_new(ptr)
      GPhoto2.check!(rc)
      @ptr = FFI::GPhoto2::CameraFile.new(ptr.read_pointer)
    end

    def free
      rc = gp_file_free(ptr)
      GPhoto2.check!(rc)
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
