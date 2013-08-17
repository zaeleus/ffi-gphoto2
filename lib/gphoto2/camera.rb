module GPhoto2
  class Camera
    include FFI::GPhoto2

    attr_reader :model, :port

    def self.all
      context = Context.new

      camera_abilities_list = CameraAbilitiesList.new(context)
      camera_list = camera_abilities_list.detect

      entries = camera_list.to_a.map { |entry| Camera.new(entry) }

      context.finalize

      entries
    end

    def self.first
      entries = all
      raise RuntimeError, 'no devices detected' if entries.empty?
      entries.first
    end

    def self.open(entry)
      camera = new(entry)

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

    def initialize(entry)
      @model, @port = entry.name, entry.value
      @dirty = false
    end

    def finalize
      @context.finalize if @context
      @window.finalize if @window
      unref if @ptr
    end
    alias_method :close, :finalize

    def capture(type = :image)
      save
      path = _capture(type)
      file_get(path)
    end

    def ptr
      @ptr || (init && @ptr)
    end

    def abilities
      @abilities || (init && @abilities)
    end

    def port_info
      @port_info || (init && @port_info)
    end

    def context
      @context ||= Context.new
    end

    def window
      @window ||= get_config
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

    def init
      new
      set_abilities(CameraAbilities.find(@model))
      set_port_info(PortInfo.find(@port))
    end

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

    def set_abilities(abilities)
      rc = gp_camera_set_abilities(ptr, abilities.ptr)
      GPhoto2.check!(rc)
      @abilities = abilities
    end

    def _capture(type)
      path = CameraFilePath.new
      rc = gp_camera_capture(ptr, type, path.ptr, context.ptr)
      GPhoto2.check!(rc)
      path
    end

    def get_config
      widget_ptr = FFI::MemoryPointer.new(FFI::GPhoto2::CameraWidget)
      rc = gp_camera_get_config(ptr, widget_ptr, context.ptr)
      GPhoto2.check!(rc)
      widget = FFI::GPhoto2::CameraWidget.new(widget_ptr.read_pointer)
      CameraWidget.factory(widget)
    end

    def set_config
      rc = gp_camera_set_config(ptr, window.ptr, context.ptr)
      GPhoto2.check!(rc)
    end

    def file_get(path, type = :normal)
      folder = path.folder
      name = path.name
      file = CameraFile.new(self, path)

      rc = gp_camera_file_get(ptr, folder, name, type, file.ptr, context.ptr)
      GPhoto2.check!(rc)

      file
    end

    def unref
      rc = gp_camera_unref(ptr)
      GPhoto2.check!(rc)
    end
  end
end
