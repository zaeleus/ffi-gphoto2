module GPhoto2
  class CameraList
    include FFI::GPhoto2

    attr_reader :ptr

    def initialize
      new
    end

    def finalize
      free
    end

    def size
      count
    end
    alias_method :length, :size

    def to_a
      size.times.map { |i| Entry.new(self, i) }
    end

    def to_ptr
      @ptr
    end

    private

    def new
      ptr = FFI::MemoryPointer.new(FFI::GPhoto2::CameraList)
      rc = gp_list_new(ptr)
      GPhoto2.check!(rc)
      @ptr = FFI::GPhoto2::CameraList.new(ptr.read_pointer)
    end

    def free
      rc = gp_list_free(ptr)
      GPhoto2.check!(rc)
    end

    def count
      rc = gp_list_count(ptr)
      GPhoto2.check!(rc)
      rc
    end
  end
end
