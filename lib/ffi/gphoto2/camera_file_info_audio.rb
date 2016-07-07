module FFI
  module GPhoto2
    class CameraFileInfoAudio < FFI::Struct
      # gphoto2/gphoto2-filesys.h
      layout :fields, CameraFileInfoFields,
             :status, CameraFileStatus,
             :size, :uint64,
             :type, [:char, 64]
    end
  end
end
