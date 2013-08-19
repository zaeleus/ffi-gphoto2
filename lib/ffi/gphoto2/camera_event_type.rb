module FFI
  module GPhoto2
    # gphoto2/gphoto2-camera.h
    CameraEventType = enum :unknown,
                           :timeout,
                           :file_added,
                           :folder_added,
                           :capture_complete
  end
end
