module FFI
  module GPhoto2
    # gphoto2/gphoto2-widget.h
    CameraWidgetType = enum :window,
                            :section,
                            :text,
                            :range,
                            :toggle,
                            :radio,
                            :menu,
                            :button,
                            :date
  end
end
