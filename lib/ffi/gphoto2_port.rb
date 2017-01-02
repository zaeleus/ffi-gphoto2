require 'ffi'

module FFI
  module GPhoto2Port
    extend FFI::Library

    ffi_lib 'libgphoto2_port'

    # constants
    require 'ffi/gphoto2_port/gp_port_result'

    # enums
    require 'ffi/gphoto2_port/gp_port_serial_parity'
    require 'ffi/gphoto2_port/gp_port_type'

    # structs
    require 'ffi/gphoto2_port/gp_port_settings_serial'
    require 'ffi/gphoto2_port/gp_port_settings_usb'
    require 'ffi/gphoto2_port/gp_port_settings_usb_disk_direct'
    require 'ffi/gphoto2_port/gp_port_settings_usb_scsi'
    require 'ffi/gphoto2_port/gp_port_settings'
    require 'ffi/gphoto2_port/gp_port'
    require 'ffi/gphoto2_port/gp_port_info'
    require 'ffi/gphoto2_port/gp_port_info_list'

    # libgphoto2_port/gphoto2/gphoto2-port-info-list.h
    attach_function :gp_port_info_get_name, [GPPortInfo, :pointer], :int
    attach_function :gp_port_info_get_path, [GPPortInfo, :pointer], :int
    attach_function :gp_port_info_get_type, [GPPortInfo, :pointer], :int

    attach_function :gp_port_info_list_new, [:pointer], :int
    attach_function :gp_port_info_list_free, [:pointer], :int
    attach_function :gp_port_info_list_load, [GPPortInfoList.by_ref], :int
    attach_function :gp_port_info_list_lookup_path, [GPPortInfoList.by_ref, :string], :int
    attach_function :gp_port_info_list_get_info, [GPPortInfoList.by_ref, :int, :pointer], :int

    # libgphoto2_port/gphoto2/gphoto2-port-result.h
    attach_function :gp_port_result_as_string, [:int], :string

    # libgphoto2_port/gphoto2/gphoto2-port.h
    attach_function :gp_port_new, [:pointer], :int
    attach_function :gp_port_free, [:pointer], :int

    attach_function :gp_port_set_info, [GPPort.by_ref, GPPortInfo], :int

    attach_function :gp_port_open, [GPPort.by_ref], :int
    attach_function :gp_port_close, [GPPort.by_ref], :int

    attach_function :gp_port_reset, [GPPort.by_ref], :int
  end
end
