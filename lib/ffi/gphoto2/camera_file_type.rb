module FFI
  module GPhoto2
    # gphoto2/gphoto2-file.h
    CameraFileType = enum :preview,
                          :normal,
                          :raw,
                          :audio,
                          :exif,
                          :metadata
  end
end
