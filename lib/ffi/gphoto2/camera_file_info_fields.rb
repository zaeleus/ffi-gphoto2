module FFI
  module GPhoto2
    # gphoto2/gphoto2-filesys.h
    CameraFileInfoFields = enum :none, 0,
                                :type, 1 << 0,
                                :size, 1 << 2,
                                :width, 1 << 3,
                                :height, 1 << 4,
                                :permissions, 1 << 5,
                                :status, 1 << 6,
                                :mtime, 1 << 7,
                                :all, 0xff
  end
end
