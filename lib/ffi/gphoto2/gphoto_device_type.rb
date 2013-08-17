module FFI
  module GPhoto2
    # gphoto2/gphoto2-abilities-list.h
    GphotoDeviceType = enum :still_camera, 0,
                            :audio_player, 1 << 0
  end
end
