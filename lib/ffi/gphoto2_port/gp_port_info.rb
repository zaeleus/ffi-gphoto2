module FFI
  module GPhoto2Port
    class GPPortInfo < FFI::Struct
      # libgphoto2_port/libgphoto2_port/gphoto2-port-info.h
      layout :type, GPPortType,
             :name, :string,
             :path, :string,
             :library_filename, :string
    end
  end
end
