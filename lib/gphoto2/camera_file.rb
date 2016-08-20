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

    # @return [GPhoto2::CameraFileInfo, nil]
    def info
      preview? ? nil : get_info
    end

    private

    def data_and_size
      @data_and_size ||= begin
        @camera.file(self) unless preview?
        get_data_and_size
      end
    end

    def default_filename
      preview? ? PREVIEW_FILENAME : @name
    end

    def new
      ptr = FFI::MemoryPointer.new(:pointer)
      rc = gp_file_new(ptr)
      GPhoto2.check!(rc)
      @ptr = FFI::GPhoto2::CameraFile.new(ptr.read_pointer)
    end

    def get_data_and_size
      data_ptr = FFI::MemoryPointer.new(:pointer)
      size_ptr = FFI::MemoryPointer.new(:ulong)

      rc = gp_file_get_data_and_size(ptr, data_ptr, size_ptr)
      GPhoto2.check!(rc)

      size = size_ptr.read_ulong
      data = data_ptr.read_pointer.read_bytes(size)

      [data, size]
    end

    def get_info
      info = FFI::GPhoto2::CameraFileInfo.new

      rc = gp_camera_file_get_info(@camera.ptr,
                                   @folder,
                                   @name,
                                   info,
                                   @camera.context.ptr)
      GPhoto2.check!(rc)

      FileCameraFileInfo.new(info[:file])
    end
  end
end
