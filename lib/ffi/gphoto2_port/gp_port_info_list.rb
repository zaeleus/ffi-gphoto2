module FFI
  module GPhoto2Port
    class GPPortInfoList < FFI::Struct
      # libgphoto2_port/libgphoto2_port/gphoto2-port-info-list.c
      layout :info, :pointer, # GPPortInfo*
             :count, :uint,
             :iolib_count, :uint
    end
  end
end
