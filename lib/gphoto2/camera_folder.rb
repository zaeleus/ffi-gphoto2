module GPhoto2
  class CameraFolder
    include FFI::GPhoto2

    # @return [String]
    attr_reader :path

    def initialize(camera, path = '/')
      @camera = camera
      @path = path
    end

    # @return [Boolean]
    def root?
      @path == '/'
    end

    # @return [String]
    def name
      if root?
        '/'
      else
        @path.rpartition('/').last
      end
    end

    # @return [Array<GPhoto2::CameraFolder>]
    def folders
      folder_list_folders
    end

    # @return [Array<GPhoto2::CameraFile>]
    def files
      folder_list_files
    end

    # @param [String] name the name of the directory
    # @return [GPhoto2::CameraFolder]
    def cd(name)
      case name
      when '.'
        self
      when '..'
        up
      else
        CameraFolder.new(@camera, File.join(@path, name))
      end
    end
    alias_method :/, :cd

    # @param [String] name the filename of the file to open
    # @return [GPhoto2::CameraFile]
    def open(name)
      CameraFile.new(@camera, @path, name)
    end

    # @return [GPhoto2::CameraFolder]
    def up
      if root?
        self
      else
        parent = @path.rpartition('/').first
        parent = '/' if parent.empty?
        CameraFolder.new(@camera, parent)
      end
    end

    # @return [String]
    def to_s
      name
    end

    private

    def folder_list_files
      list = CameraList.new

      rc = gp_camera_folder_list_files(@camera.ptr, @path, list.ptr, @camera.context.ptr)
      GPhoto2.check!(rc)

      list.to_a.map { |f| open(f.name) }
    end

    def folder_list_folders
      list = CameraList.new

      rc = gp_camera_folder_list_folders(@camera.ptr, @path, list.ptr, @camera.context.ptr)
      GPhoto2.check!(rc)

      list.to_a.map { |f| cd(f.name) }
    end
  end
end
