module GPhoto2
  class PortInfoList
    include FFI::GPhoto2Port
    include GPhoto2::Struct

    def initialize
      new
      load
    end

    def lookup_path(port)
      _lookup_path(port)
    end
    alias_method :index, :lookup_path

    def at(index)
      PortInfo.new(self, index)
    end
    alias_method :[], :at

    private

    def new
      ptr = FFI::MemoryPointer.new(GPPortInfoList)
      rc = gp_port_info_list_new(ptr)
      GPhoto2.check!(rc)
      @ptr = GPPortInfoList.new(ptr.read_pointer)
    end

    def load
      rc = gp_port_info_list_load(ptr)
      GPhoto2.check!(rc)
    end

    def _lookup_path(port)
      index = rc = gp_port_info_list_lookup_path(ptr, port)
      GPhoto2.check!(rc)
      index
    end
  end
end
