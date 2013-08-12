module FFI
  module GPhoto2
    # gphoto2/gphoto2-abilities-list.h
    CameraFileOperation = enum :GP_FILE_OPERATION_NONE, 0,
                               :GP_FILE_OPERATION_DELETE, 1 << 1,
                               :GP_FILE_OPERATION_PREVIEW, 1 << 3,
                               :GP_FILE_OPERATION_RAW, 1 << 4,
                               :GP_FILE_OPERATION_AUDIO, 1 << 5,
                               :GP_FILE_OPERATION_EXIF, 1 << 6
  end
end
