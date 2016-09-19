module FFI
  module GPhoto2Port
    class GPPortSettingsSerial < FFI::Struct
      # libgphoto2_port/libgphoto2_port/gphoto2-port.h
      layout :port, [:char, 128],
             :speed, :int,
             :bits, :int,
             :parity, GPPortSerialParity,
             :stopbits, :int
    end
  end
end
