module FFI
  module GPhoto2
    class Camera < FFI::Struct
      # gphoto2/gphoto2-camera.h
      layout :port, :pointer, # GPPort
             :fs, :pointer, # CameraFilesystem
             :functions, :pointer, # CameraFunctions
             :pl, :pointer, # CameraPrivateLibrary
             :pc, :pointer # CameraPrivateCore
    end
  end
end
