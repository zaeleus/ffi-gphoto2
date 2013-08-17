module FFI
  module GPhoto2
    # gphoto2/gphoto2-abilities-list.h
    CameraFileOperation = enum :none, 0,
                               :delete, 1 << 1,
                               :preview, 1 << 3,
                               :raw, 1 << 4,
                               :audio, 1 << 5,
                               :exif, 1 << 6
  end
end
