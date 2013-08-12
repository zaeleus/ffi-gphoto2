module FFI
  module GPhoto2
    # gphoto2/gphoto2-camera.h
    CameraCaptureType = enum :GP_CAPTURE_IMAGE,
                             :GP_CAPTURE_MOVIE,
                             :GP_CAPTURE_SOUND
  end
end
