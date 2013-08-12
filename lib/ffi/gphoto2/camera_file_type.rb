module FFI
  module GPhoto2
    # gphoto2/gphoto2-file.h
    CameraFileType = enum :GP_FILE_TYPE_PREVIEW,
                          :GP_FILE_TYPE_NORMAL,
                          :GP_FILE_TYPE_RAW,
                          :GP_FILE_TYPE_AUDIO,
                          :GP_FILE_TYPE_EXIF,
                          :GP_FILE_TYPE_METADATA
  end
end
