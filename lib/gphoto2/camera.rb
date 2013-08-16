module GPhoto2
  class Camera
    include FFI::GPhoto2

    attr_reader :port_info, :ptr

    def self.first(&blk)
      ports = Port.autodetect
      raise RuntimeError, 'no devices detected' if ports.empty?
      open(ports.first, &blk)
    end

    def self.open(port)
      camera = new(port)

      if block_given?
        begin
          yield camera
        ensure
          camera.finalize
        end
      else
        camera
      end
    end

    def initialize(port)
      @dirty = false
      @context = Context.new
      new
      set_port_info(PortInfo.find(port))
    end

    def finalize
      @context.finalize
      @window.finalize if @window
      unref
    end
    alias_method :close, :finalize

    def capture(type = :GP_CAPTURE_IMAGE)
      save
      path = _capture(type)
      file_get(path)
    end

    def window
      @window ||= CameraWidget.factory(get_config)
    end

    def config
      @config ||= window.flatten
    end

    def [](key)
      config[key]
    end

    def []=(key, value)
      self[key].value = value
      @dirty = true
      value
    end

    def dirty?
      @dirty
    end

    def save
      return false unless dirty?
      set_config
      @dirty = false
      true
    end

    def to_ptr
      @ptr
    end

    private

    def new
      ptr = FFI::MemoryPointer.new(FFI::GPhoto2::Camera)
      rc = gp_camera_new(ptr)
      GPhoto2.check!(rc)
      @ptr = FFI::GPhoto2::Camera.new(ptr.read_pointer)
    end

    def set_port_info(port_info)
      rc = gp_camera_set_port_info(ptr, port_info.ptr)
      GPhoto2.check!(rc)
      @port_info = port_info
    end

    def _capture(type)
      path = CameraFilePath.new
      rc = gp_camera_capture(ptr, type, path.ptr, @context.ptr)
      GPhoto2.check!(rc)
      path
    end

    def get_config
      widget_ptr = FFI::MemoryPointer.new(FFI::GPhoto2::CameraWidget)
      rc = gp_camera_get_config(ptr, widget_ptr, @context.ptr)
      GPhoto2.check!(rc)
      FFI::GPhoto2::CameraWidget.new(widget_ptr.read_pointer)
    end

    def set_config
      rc = gp_camera_set_config(ptr, window.ptr, @context.ptr)
      GPhoto2.check!(rc)
    end

    def file_get(path, type = :GP_FILE_TYPE_NORMAL)
      folder = path.folder
      name = path.name
      file = CameraFile.new(self, path)

      rc = gp_camera_file_get(ptr, folder, name, type, file.ptr, @context.ptr)
      GPhoto2.check!(rc)

      file
    end

    def unref
      rc = gp_camera_unref(ptr)
      GPhoto2.check!(rc)
    end
  end
end
