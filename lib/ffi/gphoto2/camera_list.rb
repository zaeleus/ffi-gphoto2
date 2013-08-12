module FFI
  module GPhoto2
    class CameraList < FFI::Struct
      # libgphoto2/gphoto2-list.c
      layout :used, :int,
             :max, :int,
             :_entry, :pointer, # Entry*
             :ref_count, :int
    end
  end
end
