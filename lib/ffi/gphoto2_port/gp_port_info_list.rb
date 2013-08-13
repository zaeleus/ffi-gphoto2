module FFI
  module GPhoto2Port
    class GPPortInfoList < FFI::ManagedStruct
      # libgphoto2_port/libgphoto2_port/gphoto2-port-info-list.c
      layout :info, :pointer, # GPPortInfo*
             :count, :uint,
             :iolib_count, :uint

      def self.release(ptr)
        FFI::GPhoto2Port.gp_port_info_list_free(ptr)
      end
    end
  end
end
