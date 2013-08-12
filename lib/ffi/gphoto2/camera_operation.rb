module FFI
  module GPhoto2
    # gphoto2/gphoto2-abilities-list.h
    CameraOperation = enum :GP_OPERATION_NONE, 0,
                           :GP_OPERATION_CAPTURE_IMAGE, 1 << 0,
                           :GP_OPERATION_CAPTURE_VIDEO, 1 << 1,
                           :GP_OPERATION_CAPTURE_AUDIO, 1 << 2,
                           :GP_OPERATION_CAPTURE_PREVIEW, 1 << 3,
                           :GP_OPERATION_CONFIG, 1 << 4,
                           :GP_OPERATION_TRIGGER_CAPTURE, 1 << 5
  end
end
