module FFI
  module GPhoto2
    # gphoto2/gphoto2-filesys.h
    CameraFilePermissions = enum :none, 0,
                                 :read, 1 << 0,
                                 :delete, 1 << 1,
                                 :all, 0xff
  end
end
