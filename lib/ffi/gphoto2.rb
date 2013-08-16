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
    attach_function :gp_abilities_list_free, [CameraAbilitiesList.by_ref], :int
    attach_function :gp_abilities_list_load, [CameraAbilitiesList.by_ref, GPContext.by_ref], :int
    attach_function :gp_abilities_list_detect, [CameraAbilitiesList.by_ref, GPhoto2Port::GPPortInfoList.by_ref, CameraList.by_ref, GPContext.by_ref], :int

    # gphoto2/gphoto2-camera.h
    attach_function :gp_camera_new, [:pointer], :int
    attach_function :gp_camera_set_port_info, [Camera.by_ref, GPhoto2Port::GPPortInfo], :int
    attach_function :gp_camera_exit, [Camera.by_ref, GPContext.by_ref], :int
    attach_function :gp_camera_ref, [Camera.by_ref], :int
    attach_function :gp_camera_unref, [Camera.by_ref], :int
    attach_function :gp_camera_get_config, [Camera.by_ref, :pointer, GPContext.by_ref], :int
    attach_function :gp_camera_set_config, [Camera.by_ref, CameraWidget.by_ref, GPContext.by_ref], :int
    attach_function :gp_camera_capture, [Camera.by_ref, CameraCaptureType, CameraFilePath.by_ref, GPContext.by_ref], :int
    attach_function :gp_camera_file_get, [Camera.by_ref, :string, :string, CameraFileType, CameraFile.by_ref, GPContext.by_ref], :int

    # gphoto2/gphoto2-context.h
    attach_function :gp_context_new, [], :pointer
    attach_function :gp_context_ref, [GPContext.by_ref], :void
    attach_function :gp_context_unref, [GPContext.by_ref], :void

    # gphoto2/gphoto2-file.h
    attach_function :gp_file_new, [:pointer], :int
    attach_function :gp_file_free, [CameraFile.by_ref], :int
    attach_function :gp_file_get_data_and_size, [CameraFile.by_ref, :pointer, :pointer], :int

    # gphoto2/gphoto2-list.h
    attach_function :gp_list_new, [:pointer], :int
    attach_function :gp_list_free, [CameraList.by_ref], :int
    attach_function :gp_list_count, [CameraList.by_ref], :int
    attach_function :gp_list_get_name, [CameraList.by_ref, :int, :pointer], :int
    attach_function :gp_list_get_value, [CameraList.by_ref, :int, :pointer], :int

    # gphoto2/gphoto2-widget.h
    attach_function :gp_widget_free, [CameraWidget.by_ref], :int
    attach_function :gp_widget_count_children, [CameraWidget.by_ref], :int
    attach_function :gp_widget_get_child, [CameraWidget.by_ref, :int, :pointer], :int
    attach_function :gp_widget_set_value, [CameraWidget.by_ref, :pointer], :int
    attach_function :gp_widget_get_value, [CameraWidget.by_ref, :pointer], :int
    attach_function :gp_widget_get_name, [CameraWidget.by_ref, :pointer], :int
    attach_function :gp_widget_get_type, [CameraWidget.by_ref, :pointer], :int
    attach_function :gp_widget_get_range, [CameraWidget.by_ref, :pointer, :pointer, :pointer], :int
    attach_function :gp_widget_count_choices, [CameraWidget.by_ref], :int
    attach_function :gp_widget_get_choice, [CameraWidget.by_ref, :int, :pointer], :int
  end
end
