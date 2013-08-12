module FFI
  module GPhoto2
    class CameraFilePath < FFI::Struct
      # gphoto2/gphoto2-camera.h
      layout :name, [:char, 128],
             :folder, [:char, 1024]
    end
  end
end
