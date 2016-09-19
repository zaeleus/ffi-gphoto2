module FFI
  module GPhoto2Port
    class GPPortSettingsUSB < FFI::Struct
      # libgphoto2_port/libgphoto2_port/gphoto2-port.h
      layout :inep, :int,
             :outep, :int,
             :intep, :int,
             :config, :int,
             :interface, :int,
             :altsetting, :int,
             :maxpacketsize, :int,
             :port, [:char, 64]
    end
  end
end
