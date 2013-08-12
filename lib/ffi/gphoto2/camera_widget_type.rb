module FFI
  module GPhoto2
    # gphoto2/gphoto2-widget.h
    CameraWidgetType = enum :GP_WIDGET_WINDOW,
                            :GP_WIDGET_SECTION,
                            :GP_WIDGET_TEXT,
                            :GP_WIDGET_RANGE,
                            :GP_WIDGET_TOGGLE,
                            :GP_WIDGET_RADIO,
                            :GP_WIDGET_MENU,
                            :GP_WIDGET_BUTTON,
                            :GP_WIDGET_DATE
  end
end
