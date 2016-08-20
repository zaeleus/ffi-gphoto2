module GPhoto2
  class CameraList
    include FFI::GPhoto2
    include GPhoto2::Struct

    def initialize
      new
    end

    # @return [Integer]
    def size
      count
    end
    alias_method :length, :size

    # @return [Array<GPhoto2::Entry>]
    def to_a
      size.times.map { |i| Entry.new(self, i) }
    end

    private

    def new
      ptr = FFI::MemoryPointer.new(:pointer)
      rc = gp_list_new(ptr)
      GPhoto2.check!(rc)
      @ptr = FFI::GPhoto2::CameraList.new(ptr.read_pointer)
    end

    def count
      rc = gp_list_count(ptr)
      GPhoto2.check!(rc)
      rc
    end
  end
end
