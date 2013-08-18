module GPhoto2
  class CameraFile
    include FFI::GPhoto2

    attr_reader :ptr

    def initialize(camera, camera_file_path = nil)
      @camera = camera
      @camera_file_path = camera_file_path
      new
    end

    def save(pathname = default_filename)
      File.binwrite(pathname, data)
    end

    def data
      data_and_size.first
    end

    def size
      data_and_size.last
    end

    def to_ptr
      @ptr
    end

    private

    def data_and_size
      @data_and_size ||= get_data_and_size
    end

    def default_filename
      @camera_file_path ? @camera_file_path.name : 'capture_preview'
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
