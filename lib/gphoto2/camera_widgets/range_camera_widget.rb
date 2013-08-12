module GPhoto2
  class RangeCameraWidget < CameraWidget
    def range
      min, max, inc = get_range
      (min..max).step(inc).to_a
    end

    protected

    def get_value
      val = FFI::MemoryPointer.new(:float)
      rc = gp_widget_get_value(ptr, val)
      GPhoto2.check!(rc)
      val.read_float
    end

    def set_value(value)
      val = FFI::MemoryPointer.new(:float)
      val.write_float(value)
      rc = gp_widget_set_value(ptr, val)
      GPhoto2.check!(rc)
    end

    private

    def get_range
      min = FFI::MemoryPointer.new(:float)
      max = FFI::MemoryPointer.new(:float)
      inc = FFI::MemoryPointer.new(:float)

      rc = gp_widget_get_range(ptr, min, max, inc)
      GPhoto2.check!(rc)

      [min.read_float, max.read_float, inc.read_float]
    end
  end
end
