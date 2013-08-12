require 'ffi/gphoto2_port/gp_port_type'

module FFI
  module GPhoto2
    class CameraAbilities < FFI::Struct
      # gphoto2/gphoto2-abilities-list.h
      layout :model, [:char, 128],
             :status, CameraDriverStatus,

             :port, GPhoto2Port::GPPortType,
             :speed, [:int, 64],

             :operations, CameraOperation,
             :file_operations, CameraFileOperation,
             :folder_operations, CameraFolderOperation,

             :usb_vendor, :int,
             :usb_product, :int,
             :usb_class, :int,
             :usb_subclass, :int,
             :usb_protocol, :int,

             :library, [:char, 1024],
             :id, [:char, 1024],

             :device_type, GphotoDeviceType,

             :reserved2, :int,
             :reserved3, :int,
             :reserved4, :int,
             :reserved5, :int,
             :reserved6, :int,
             :reserved7, :int,
             :reserved8, :int
    end
  end
end
