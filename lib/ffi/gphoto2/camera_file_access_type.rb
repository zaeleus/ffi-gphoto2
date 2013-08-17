module FFI
  module GPhoto2
    # gphoto2/gphoto2-file.h
    CameraFileAccessType = enum :memory,
                                :fd,
                                :handler
  end
end
