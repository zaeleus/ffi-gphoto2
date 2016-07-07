module FFI
  module GPhoto2
    class CameraFileInfo < FFI::Struct
      # libgphoto2/gphoto2-filesys.h
      layout :preview, CameraFileInfoPreview,
             :file, CameraFileInfoFile,
             :audio, CameraFileInfoAudio
    end
  end
end
