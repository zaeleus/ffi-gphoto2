module FFI
  module GPhoto2
    class CameraFileInfoFile < FFI::Struct
      # gphoto2/gphoto2-filesys.h
      layout :fields, CameraFileInfoFields,
             :status, CameraFileStatus,
             :size, :uint64,
             :type, [:char, 64],
             :width, :uint32,
             :height, :uint32,
             :permissions, CameraFilePermissions,
             :mtime, :time_t
    end
  end
end
