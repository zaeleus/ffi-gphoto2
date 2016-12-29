module GPhoto2
  class Port
    include FFI::GPhoto2Port
    include GPhoto2::Struct

    def initialize
      @ptr = new
    end

    # @param [PortInfo] info
    # @return [PortInfo]
    def info=(info)
      set_info(info)
      info
    end

    # @return [void]
    def open
      _open
    end

    # @return [void]
    def close
      _close
    end

    # @return [void]
    def reset
      _reset
    end

    private

    def new
      ptr = FFI::MemoryPointer.new(:pointer)
      rc = gp_port_new(ptr)
      GPhoto2.check!(rc)
      FFI::GPhoto2Port::GPPort.new(ptr.read_pointer)
    end

    def _open
      rc = gp_port_open(ptr)
      GPhoto2.check!(rc)
    end

    def _close
      rc = gp_port_close(ptr)
      GPhoto2.check!(rc)
    end

    def _reset
      rc = gp_port_reset(ptr)
      GPhoto2.check!(rc)
    end

    def set_info(port_info)
      rc = gp_port_set_info(ptr, port_info.ptr)
      GPhoto2.check!(rc)
    end
  end
end
