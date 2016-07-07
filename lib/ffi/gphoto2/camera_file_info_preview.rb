module FFI
  module GPhoto2
    class CameraFileInfoPreview < FFI::Struct
      # gphoto2/gphoto2-filesys.h
      layout :fields, CameraFileInfoFields,
             :status, CameraFileStatus,
             :size, :uint64,
             :type, [:char, 64],
             :width, :uint32,
             :height, :uint32
    end
  end
end
