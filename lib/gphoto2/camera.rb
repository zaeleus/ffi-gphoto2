module GPhoto2
  class Camera
    include FFI::GPhoto2
    include GPhoto2::Struct

    include Capture
    include Configuration
    include Event
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

    def unref
      rc = gp_camera_unref(ptr)
      GPhoto2.check!(rc)
    end
  end
end
