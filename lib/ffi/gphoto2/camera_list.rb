module FFI
  module GPhoto2
    class CameraList < FFI::ManagedStruct
      # libgphoto2/gphoto2-list.c
      layout :used, :int,
             :max, :int,
             :_entry, Entry.by_ref,
             :ref_count, :int

      def self.release(ptr)
        FFI::GPhoto2.gp_list_free(ptr)
      end
    end
  end
end
