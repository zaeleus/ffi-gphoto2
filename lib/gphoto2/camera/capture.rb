module GPhoto2
  class Camera
    module Capture
      def capture(type = :image)
        save
        path = _capture(type)
        CameraFile.new(self, path.folder, path.name)
      end

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
    end
  end
end
