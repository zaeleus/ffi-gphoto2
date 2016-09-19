module FFI
  module GPhoto2Port
    class GPPortSettings < FFI::Struct
      # libgphoto2_port/libgphoto2_port/gphoto2-port.h
      layout :serial, GPPortSettingsSerial,
             :usb, GPPortSettingsUSB,
             :usbdiskdirect, GPPortSettingsUsbDiskDirect,
             :usbscsi, GPPortSettingsUsbScsi
    end
  end
end
