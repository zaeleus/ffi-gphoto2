module GPhoto2
  class CameraFolder
    include FFI::GPhoto2

    attr_reader :path

    def initialize(camera, path = '/')
      @camera = camera
      @path = path
    end

    def root?
      @path == '/'
    end

    def folders
      folder_list_folders
    end

    def files
      folder_list_files
    end

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

    def open(name)
      CameraFile.new(@camera, @path, name)
    end

    def up
      if root?
        self
      else
        parent = @path.rpartition('/').first
        parent = '/' if parent.empty?
        CameraFolder.new(@camera, parent)
      end
    end

    def to_s
      @path
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
