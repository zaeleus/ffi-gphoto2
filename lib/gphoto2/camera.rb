module GPhoto2
  class Camera
    include FFI::GPhoto2
    include GPhoto2::Struct

    include Configuration
    include Filesystem

    attr_reader :model, :port

    def self.all
      context = Context.new

      abilities = CameraAbilitiesList.new(context)
      cameras = abilities.detect

      entries = cameras.to_a.map do |entry|
        model, port = entry.name, entry.value
        Camera.new(model, port)
      end

      context.finalize

      entries
    end

    def self.first
      entries = all
      raise RuntimeError, 'no devices detected' if entries.empty?
      entries.first
    end

    def self.open(model, port)
      camera = new(model, port)

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

    def self.where(condition)
      name = condition.keys.first
      pattern = condition.values.first
      all.select { |c| c.send(name).match(pattern) }
    end

    def initialize(model, port)
      super
      @model, @port = model, port
    end

    def finalize
      @context.finalize if @context
      @window.finalize if @window
      unref if @ptr
    end
    alias_method :close, :finalize

    def exit
      _exit
    end

    def capture(type = :image)
      save
      path = _capture(type)
      CameraFile.new(self, path.folder, path.name)
    end

    def preview
      save
      capture_preview
    end

    # timeout in milliseconds
    def wait(timeout = 2000)
      wait_for_event(timeout)
    end

    def wait_for(event_type)
      begin
        event = wait
      end until event.type == event_type

      event
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

    def can?(operation)
      (abilities[:operations] & CameraOperation[operation]) != 0
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

    def _exit
      rc = gp_camera_exit(ptr, context.ptr)
      GPhoto2.check!(rc)
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

    def capture_preview
      file = CameraFile.new(self)
      rc = gp_camera_capture_preview(ptr, file.ptr, context.ptr)
      GPhoto2.check!(rc)
      file
    end

    def unref
      rc = gp_camera_unref(ptr)
      GPhoto2.check!(rc)
    end

    def wait_for_event(timeout)
      # assume CameraEventType is an int
      type = FFI::MemoryPointer.new(:int)

      data = FFI::MemoryPointer.new(:pointer)
      data_ptr = FFI::MemoryPointer.new(:pointer)
      data_ptr.write_pointer(data)

      rc = gp_camera_wait_for_event(ptr, timeout, type, data_ptr, context.ptr)
      GPhoto2.check!(rc)

      type = CameraEventType[type.read_int]
      data = data_ptr.read_pointer

      data =
        case type
        when :unknown
          data.null? ? nil : data.read_string
        when :file_added
          path_ptr = FFI::GPhoto2::CameraFilePath.new(data)
          path = CameraFilePath.new(path_ptr)
          CameraFile.new(self, path.folder, path.name)
        when :folder_added
          path_ptr = FFI::GPhoto2::CameraFilePath.new(data)
          path = CameraFilePath.new(path_ptr)
          CameraFolder.new(self, '%s/%s' % [path.folder, path.name])
        else
          nil
        end

      CameraEvent.new(type, data)
    end
  end
end
