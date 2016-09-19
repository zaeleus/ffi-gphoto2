module FFI
  module GPhoto2Port
    class GPPort < FFI::ManagedStruct
      # libgphoto2_port/libgphoto2_port/gphoto2-port.h
      layout :type, GPPortType,
             :settings, GPPortSettings,
             :settings_pending, GPPortSettings,
             :timeout, :int,
             :pl, :pointer, # GPPortPrivateLibrary *
             :pc, :pointer # GPPortPrivateCore *

      def self.release(ptr)
        FFI::GPhoto2.gp_port_free(ptr)
      end
    end
  end
end
