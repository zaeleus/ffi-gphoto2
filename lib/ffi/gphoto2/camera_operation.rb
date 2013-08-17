module FFI
  module GPhoto2
    # gphoto2/gphoto2-abilities-list.h
    CameraOperation = enum :none, 0,
                           :capture_image, 1 << 0,
                           :capture_video, 1 << 1,
                           :capture_audio, 1 << 2,
                           :capture_preview, 1 << 3,
                           :config, 1 << 4,
                           :trigger_capture, 1 << 5
  end
end
