module FFI
  module GPhoto2
    class CameraWidget < FFI::Struct
      # libgphoto2/gphoto2-widget.c
      layout :type, CameraWidgetType,
             :label, [:char, 256],
             :info, [:char, 1024],
             :name, [:char, 256],

             :parent, CameraWidget.by_ref,

             :value_string, :string,
             :value_int, :int,
             :value_float, :float,

             :choice, :pointer,
             :choice_count, :int,

             :min, :float,
             :max, :float,
             :increment, :float,

             :children, :pointer, # CameraWidget**
             :children_count, :int,

             :changed, :int,
             :readonly, :int,
             :ref_count, :int,
             :id, :int,
             :callback, :pointer # CameraWidgetCallback
    end
  end
end
