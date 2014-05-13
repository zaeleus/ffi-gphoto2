module GPhoto2
  class PortInfo
    include FFI::GPhoto2Port

    attr_reader :ptr

    def self.find(port)
      port_info_list = PortInfoList.new
      index = port_info_list.lookup_path(port)
      port_info_list[index]
    end

    def initialize(port_info_list, index)
      @port_info_list = port_info_list
      @index = index
      new
    end

    def name
      get_name
    end

    def path
      get_path
    end

    def type
      get_type
    end

    def to_ptr
      @ptr
    end

    private

    def new
      ptr = FFI::MemoryPointer.new(GPPortInfo)
      rc = gp_port_info_list_get_info(@port_info_list.ptr, @index, ptr)
      GPhoto2.check!(rc)
      @ptr = GPPortInfo.new(ptr.read_pointer)
    end

    def get_name
      name = FFI::MemoryPointer.new(:string)
      name_ptr = FFI::MemoryPointer.new(:pointer)
      name_ptr.write_pointer(name)

      rc = gp_port_info_get_name(ptr, name_ptr)
      GPhoto2.check!(rc)

      name_ptr = name_ptr.read_pointer
      name_ptr.null? ? nil : name_ptr.read_string
    end

    def get_path
      path = FFI::MemoryPointer.new(:string)
      path_ptr = FFI::MemoryPointer.new(:pointer)
      path_ptr.write_pointer(path)

      rc = gp_port_info_get_path(ptr, path_ptr)
      GPhoto2.check!(rc)

      path_ptr = path_ptr.read_pointer
      path_ptr.null? ? nil : path_ptr.read_string
    end

    def get_type
      # assume GPPortType is an int
      type = FFI::MemoryPointer.new(:int)
      rc = gp_port_info_get_type(ptr, type)
      GPhoto2.check!(rc)
      GPPortType[type.read_int]
    end
  end
end
