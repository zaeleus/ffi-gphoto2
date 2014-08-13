module GPhoto2
  class Camera
    module Configuration
      def initialize(model, port)
        @dirty = false
      end

      def window
        @window ||= get_config
      end

      def config
        @config ||= window.flatten
      end

      def [](key)
        config[key.to_s]
      end

      def []=(key, value)
        self[key].value = value
        @dirty = true
        value
      end

      def save
        return false unless dirty?
        set_config
        @dirty = false
        true
      end

      def update(attributes = {})
        attributes.each do |key, value|
          self[key] = value
        end

        save
      end

      def dirty?
        @dirty
      end

      private

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
    end
  end
end
