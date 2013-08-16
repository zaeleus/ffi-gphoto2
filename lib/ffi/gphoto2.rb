require 'ffi/gphoto2_port'

module FFI
  module GPhoto2
    extend FFI::Library

    ffi_lib 'libgphoto2'

    # enums
    require 'ffi/gphoto2/camera_capture_type'
    require 'ffi/gphoto2/camera_driver_status'
    require 'ffi/gphoto2/camera_file_access_type'
    require 'ffi/gphoto2/camera_file_operation'
    require 'ffi/gphoto2/camera_file_type'
    require 'ffi/gphoto2/camera_folder_operation'
    require 'ffi/gphoto2/camera_operation'
    require 'ffi/gphoto2/camera_widget_type'
    require 'ffi/gphoto2/gphoto_device_type'

    # structs
    require 'ffi/gphoto2/camera'
    require 'ffi/gphoto2/camera_abilities'
    require 'ffi/gphoto2/camera_abilities_list'
    require 'ffi/gphoto2/camera_file'
    require 'ffi/gphoto2/camera_file_path'
    require 'ffi/gphoto2/camera_list'
    require 'ffi/gphoto2/camera_widget'
    require 'ffi/gphoto2/entry'
    require 'ffi/gphoto2/gp_context'

    # gphoto2/gphoto2-abilities-list.h
    attach_function :gp_abilities_list_new, [:pointer], :int
    attach_function :gp_abilities_list_free, [:pointer], :int
    attach_function :gp_abilities_list_load, [:pointer, :pointer], :int
    attach_function :gp_abilities_list_detect, [:pointer, :pointer, :pointer, :pointer], :int

    # gphoto2/gphoto2-camera.h
    attach_function :gp_camera_new, [:pointer], :int
    attach_function :gp_camera_set_port_info, [:pointer, GPhoto2Port::GPPortInfo], :int
    attach_function :gp_camera_exit, [:pointer, :pointer], :int
    attach_function :gp_camera_ref, [:pointer], :int
    attach_function :gp_camera_unref, [:pointer], :int
    attach_function :gp_camera_get_config, [:pointer, :pointer, :pointer], :int
    attach_function :gp_camera_set_config, [:pointer, :pointer, :pointer], :int
    attach_function :gp_camera_capture, [:pointer, CameraCaptureType, :pointer, :pointer], :int
    attach_function :gp_camera_file_get,
                    [:pointer, :string, :string, CameraFileType, :pointer, :pointer],
                    :int

    # gphoto2/gphoto2-context.h
    attach_function :gp_context_new, [], :pointer
    attach_function :gp_context_ref, [:pointer], :void
    attach_function :gp_context_unref, [:pointer], :void

    # gphoto2/gphoto2-file.h
    attach_function :gp_file_new, [:pointer], :int
    attach_function :gp_file_free, [:pointer], :int
    attach_function :gp_file_get_data_and_size, [:pointer, :pointer, :pointer], :int

    # gphoto2/gphoto2-list.h
    attach_function :gp_list_new, [:pointer], :int
    attach_function :gp_list_free, [:pointer], :int
    attach_function :gp_list_count, [:pointer], :int
    attach_function :gp_list_get_name, [:pointer, :int, :pointer], :int
    attach_function :gp_list_get_value, [:pointer, :int, :pointer], :int

    # gphoto2/gphoto2-widget.h
    attach_function :gp_widget_free, [:pointer], :int
    attach_function :gp_widget_get_name, [:pointer, :pointer], :int
    attach_function :gp_widget_get_type, [:pointer, :pointer], :int
    attach_function :gp_widget_set_value, [:pointer, :pointer], :int
    attach_function :gp_widget_get_value, [:pointer, :pointer], :int
    attach_function :gp_widget_count_children, [:pointer], :int
    attach_function :gp_widget_get_child, [:pointer, :int, :pointer], :int
    attach_function :gp_widget_get_range, [:pointer, :pointer, :pointer, :pointer], :int
    attach_function :gp_widget_count_choices, [:pointer], :int
    attach_function :gp_widget_get_choice, [:pointer, :int, :pointer], :int 
  end
end
