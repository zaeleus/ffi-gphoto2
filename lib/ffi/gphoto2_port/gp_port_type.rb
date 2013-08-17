module FFI
  module GPhoto2Port
    # libgphoto2_port/gphoto2/gphoto2-port-info-list.h
    GPPortType = enum :none, 0,
                      :serial, 1 << 0,
                      :usb, 1 << 2,
                      :disk, 1 << 3,
                      :ptpip, 1 << 4,
                      :usb_disk_direct, 1 << 5,
                      :usb_scsi, 1 << 6
  end
end
