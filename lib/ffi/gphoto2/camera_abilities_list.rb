require 'ffi/gphoto2/camera_abilities'

module FFI
  module GPhoto2
    class CameraAbilitiesList < FFI::ManagedStruct
      # libgphoto2/gphoto2-abilities-list.c
      layout :count, :int,
             :abilities, CameraAbilities.by_ref

      def self.release(ptr)
        FFI::GPhoto2.gp_abilities_list_free(ptr)
      end
    end
  end
end
