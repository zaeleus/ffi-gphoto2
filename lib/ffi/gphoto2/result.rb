module FFI
  module GPhoto2
    module Result

      def self.all
        {
          # libgphoto2_port/gphoto2/gphoto2-port-result.h
          0 => :GP_OK,
          -1 => :GP_ERROR,
          -2 => :GP_ERROR_BAD_PARAMETERS,
          -3 => :GP_ERROR_NO_MEMORY,
          -4 => :GP_ERROR_LIBRARY,
          -5 => :GP_ERROR_UNKNOWN_PORT,
          -6 => :GP_ERROR_NOT_SUPPORTED,
          -7 => :GP_ERROR_IO,
          -8 => :GP_ERROR_FIXED_LIMIT_EXCEEDED,
          -10 => :GP_ERROR_TIMEOUT,
          -20 => :GP_ERROR_IO_SUPPORTED_SERIAL,
          -21 => :GP_ERROR_IO_SUPPORTED_USB,
          -31 => :GP_ERROR_IO_INIT,
          -34 => :GP_ERROR_IO_READ,
          -35 => :GP_ERROR_IO_WRITE,
          -37 => :GP_ERROR_IO_UPDATE,
          -41 => :GP_ERROR_IO_SERIAL_SPEED,
          -51 => :GP_ERROR_IO_USB_CLEAR_HALT,
          -52 => :GP_ERROR_IO_USB_FIND,
          -53 => :GP_ERROR_IO_USB_CLAIM,
          -60 => :GP_ERROR_IO_LOCK,
          -70 => :GP_ERROR_HAL,

          # libgphoto2/gphoto2/gphoto2-result.h
          -102 => :GP_ERROR_CORRUPTED_DATA,
          -103 => :GP_ERROR_FILE_EXISTS,
          -105 => :GP_ERROR_MODEL_NOT_FOUND,
          -107 => :GP_ERROR_DIRECTORY_NOT_FOUND,
          -108 => :GP_ERROR_FILE_NOT_FOUND,
          -109 => :GP_ERROR_DIRECTORY_EXISTS,
          -110 => :GP_ERROR_CAMERA_BUSY,
          -111 => :GP_ERROR_PATH_NOT_ABSOLUTE,
          -112 => :GP_ERROR_CANCEL,
          -113 => :GP_ERROR_CAMERA_ERROR,
          -114 => :GP_ERROR_OS_FAILURE,
          -115 => :GP_ERROR_NO_SPACE
        }
      end

    end
  end
end
