module GPhoto2
  class Entry
    include FFI::GPhoto2

    def initialize(camera_list, index)
      @camera_list = camera_list
      @index = index
    end

    # @return [String]
    def name
      get_name
    end

    # @return [String]
    def value
      get_value
    end

    private

    def get_name
      ptr = FFI::MemoryPointer.new(:pointer)

      rc = gp_list_get_name(@camera_list.ptr, @index, ptr)
      GPhoto2.check!(rc)

      ptr = ptr.read_pointer
      ptr.null? ? nil : ptr.read_string
    end

    def get_value
      ptr = FFI::MemoryPointer.new(:pointer)

      rc = gp_list_get_value(@camera_list.ptr, @index, ptr)
      GPhoto2.check!(rc)

      ptr = ptr.read_pointer
      ptr.null? ? nil : ptr.read_string
    end
  end
end
