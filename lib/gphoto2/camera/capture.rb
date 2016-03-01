module GPhoto2
  class Camera
    module Capture
      # @example
      #   # Take a photo.
      #   file = camera.capture
      #
      #   # And save it to the current working directory.
      #   file.save
      #
      # @param [CameraCaptureType] type
      # @return [GPhoto2::CameraFile]
      def capture(type = :image)
        save
        path = _capture(type)
        CameraFile.new(self, path.folder, path.name)
      end

      # Triggers a capture and immedately returns.
      #
      # A camera trigger is the first half of a {#capture}. Instead of
      # returning a {GPhoto2::CameraFile}, a trigger immediately returns and
      # the caller has to poll for events.
      #
      # @example
      #   camera.trigger
      #   event = camera.wait_for(:file_added)
      #   event.data # => CameraFile
      #
      # @return [void]
      def trigger
        save
        trigger_capture
      end

      # Captures a preview from the camera.
      #
      # Previews are not stored on the camera but are returned as data in a
      # {GPhoto2::CameraFile}.
      #
      # @example
      #   # Capturing a preview is like using `Camera#capture`.
      #   file = camera.preview
      #
      #   # The resulting file will have neither a folder nor name.
      #   file.preview?
      #   # => true
      #
      #   # But it will contain image data from the camera.
      #   file.data
      #   # => "\xFF\xD8\xFF\xDB\x00\x84\x00\x06..."
      #
      # @return [GPhoto2::CameraFile]
      def preview
        save
        capture_preview
      end

      private

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

      def trigger_capture
        rc = gp_camera_trigger_capture(ptr, context.ptr)
        GPhoto2.check!(rc)
      end
    end
  end
end
