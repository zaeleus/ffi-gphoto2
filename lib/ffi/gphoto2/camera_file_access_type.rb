module FFI
  module GPhoto2
    # gphoto2/gphoto2-file.h
    CameraFileAccessType = enum :GP_FILE_ACCESSTYPE_MEMORY,
                                :GP_FILE_ACCESSTYPE_FD,
                                :GP_FILE_ACCESSTYPE_HANDLER
  end
end
