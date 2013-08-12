module FFI
  module GPhoto2
    class Entry < FFI::Struct
      # libgphoto2/gphoto2-list.c
      layout :name, :string,
             :value, :string
    end
  end
end
