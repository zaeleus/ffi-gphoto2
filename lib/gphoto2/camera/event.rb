module GPhoto2
  class Camera
    module Event
      # @param [Integer] timeout time to wait in milliseconds
      # @return [CameraEvent]
      def wait(timeout = 2000)
        wait_for_event(timeout)
      end

      # @param [CameraEventType] event_type
      # @return [CameraEvent]
      def wait_for(event_type)
        begin
          event = wait
        end until event.type == event_type

        event
      end

      private

      def wait_for_event(timeout)
        # assume CameraEventType is an int
        type_ptr = FFI::MemoryPointer.new(:int)
        data_ptr = FFI::MemoryPointer.new(:pointer)

        rc = gp_camera_wait_for_event(ptr, timeout, type_ptr, data_ptr, context.ptr)
        GPhoto2.check!(rc)

        type = FFI::GPhoto2::CameraEventType[type_ptr.read_int]
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
end
