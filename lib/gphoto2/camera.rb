module GPhoto2
  class Camera
    include FFI::GPhoto2
    include GPhoto2::Struct

    include Capture
    include Configuration
    include Event
    include Filesystem

    # @return [String]
    attr_reader :model

    # @return [String]
    attr_reader :port

    # @example
    #   cameras = GPhoto2::Camera.all
    #   # => [#<GPhoto2::Camera>, #<GPhoto2::Camera>, ...]
    #
    # @return [Array<GPhoto2::Camera>] a list of all available devices
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

    # @example
    #   camera = GPhoto2::Camera.first
    #
    #   begin
    #     # ...
    #   ensure
    #     camera.finalize
    #   end
    #
    #   # Alternatively, pass a block, which will automatically close the camera.
    #   GPhoto2::Camera.first do |camera|
    #     # ...
    #   end
    #
    # @return [GPhoto2::Camera] the first detected camera
    # @raise [RuntimeError] when no devices are detected
    def self.first(&blk)
      entries = all
      raise RuntimeError, 'no devices detected' if entries.empty?
      camera = entries.first
      autorelease(camera, &blk)
    end

    # @example
    #   model = 'Nikon DSC D5100 (PTP mode)'
    #   port = 'usb:250,006'
    #
    #   camera = GPhoto2::Camera.open(model, port)
    #
    #   begin
    #     # ...
    #   ensure
    #     camera.finalize
    #   end
    #
    #   # Alternatively, pass a block, which will automatically close the camera.
    #   GPhoto2::Camera.open(model, port) do |camera|
    #     # ...
    #   end
    #
    # @param [String] model
    # @param [String] port
    # @return [GPhoto2::Camera]
    def self.open(model, port, &blk)
      camera = new(model, port)
      autorelease(camera, &blk)
    end

    # Filters devices by a given condition.
    #
    # Filter keys can be either `model` or `port`. Only the first filter is
    # used.
    #
    # @example
    #   # Find the cameras whose model names contain Nikon.
    #   cameras = GPhoto2::Camera.where(model: /nikon/i)
    #
    #   # Select a camera by its port.
    #   camera = GPhoto2::Camera.where(port: 'usb:250,004').first
    #
    # @param [Hash] condition
    # @return [Array<GPhoto2::Camera>]
    def self.where(condition)
      name = condition.keys.first
      pattern = condition.values.first
      all.select { |c| c.send(name).match(pattern) }
    end

    # @param [String] model
    # @param [String] port
    def initialize(model, port)
      super
      @model, @port = model, port
    end

    # @return [void]
    def finalize
      @context.finalize if @context
      @window.finalize if @window
      unref if @ptr
    end
    alias_method :close, :finalize

    # @return [void]
    def exit
      _exit
    end

    # @return [FFI::GPhoto::Camera]
    def ptr
      @ptr || (init && @ptr)
    end

    # @return [GPhoto2::CameraAbilities]
    def abilities
      @abilities || (init && @abilities)
    end

    # @return [GPhoto2::PortInfo]
    def port_info
      @port_info || (init && @port_info)
    end

    # @return [GPhoto2::Context]
    def context
      @context ||= Context.new
    end

    # @example
    #   camera.can? :capture_image
    #   # => true
    #
    # @see FFI::GPhoto2::CameraOperation
    # @param [CameraOperation] operation
    # @return [Boolean]
    def can?(operation)
      (abilities.operations & (CameraOperation[operation] || 0)) != 0
    end

    private

    # Ensures the given camera is finalized when passed a block.
    #
    # If no block is given, the camera is returned and the caller must must
    # manually close it.
    def self.autorelease(camera)
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
