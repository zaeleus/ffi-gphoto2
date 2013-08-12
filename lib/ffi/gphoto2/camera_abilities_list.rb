require 'ffi/gphoto2/camera_abilities'

module FFI
  module GPhoto2
    class CameraAbilitiesList < FFI::Struct
      # libgphoto2/gphoto2-abilities-list.c
      layout :count, :int,
             :abilities, :pointer # CameraAbilities*
    end
  end
end
