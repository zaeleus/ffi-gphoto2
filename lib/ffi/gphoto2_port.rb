module FFI
  module GPhoto2Port
    extend FFI::Library

    ffi_lib 'libgphoto2_port'

    # constants
    require 'ffi/gphoto2_port/gp_port_result'

    # enums
    require 'ffi/gphoto2_port/gp_port_type'

    # structs
    require 'ffi/gphoto2_port/gp_port_info'
    require 'ffi/gphoto2_port/gp_port_info_list'

    # libgphoto2_port/gphoto2/gphoto2-port-info-list.h
    attach_function :gp_port_info_get_name, [GPPortInfo.by_value, :pointer], :int
    attach_function :gp_port_info_get_path, [GPPortInfo.by_value, :pointer], :int 
    attach_function :gp_port_info_get_type, [GPPortInfo.by_value, :pointer], :int 

    attach_function :gp_port_info_list_new, [:pointer], :int
    attach_function :gp_port_info_list_free, [:pointer], :int
    attach_function :gp_port_info_list_load, [:pointer], :int
    attach_function :gp_port_info_list_lookup_path, [:pointer, :string], :int
    attach_function :gp_port_info_list_get_info, [:pointer, :int, :pointer], :int
  end
end
