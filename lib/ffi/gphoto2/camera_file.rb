module FFI
  module GPhoto2
    class CameraFile < FFI::Struct
      MAX_PATH = 256

      # libgphoto2/gphoto2-file.c
      layout :mime_type, [:char, 64],
             :name, [:char, MAX_PATH],
             :ref_count, :int,
             :mtime, :time_t,

             :accesstype, CameraFileAccessType,

             :size, :ulong,
             :data, :pointer, # unsigned char*
             :offset, :ulong,

             :fd, :int,

             :handler, :pointer, # CameraFileHandler
             :private, :pointer # void*
    end
  end
end
