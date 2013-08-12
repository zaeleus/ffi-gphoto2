module FFI
  module GPhoto2
    # gphoto2/gphoto2-abilities-list.h
    CameraDriverStatus = enum :GP_DRIVER_STATUS_PRODUCTION,
                              :GP_DRIVER_STATUS_TESTING,
                              :GP_DRIVER_STATUS_EXPERIMENTAL,
                              :GP_DRIVER_STATUS_DEPRECATED
  end
end
