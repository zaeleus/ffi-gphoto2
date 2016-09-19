module FFI
  module GPhoto2Port
    class GPPortSettingsUsbDiskDirect < FFI::Struct
      # libgphoto2_port/libgphoto2_port/gphoto2-port.h
      layout :path, [:char, 128]
    end
  end
end
