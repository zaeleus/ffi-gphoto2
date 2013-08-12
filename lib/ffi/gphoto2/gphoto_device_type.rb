module FFI
  module GPhoto2
    # gphoto2/gphoto2-abilities-list.h
    GphotoDeviceType = enum :GP_DEVICE_STILL_CAMERA, 0,
                            :GP_DEVICE_AUDIO_PLAYER, 1 << 0
  end
end
