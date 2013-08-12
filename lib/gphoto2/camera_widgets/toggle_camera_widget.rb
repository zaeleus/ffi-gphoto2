module GPhoto2
  class ToggleCameraWidget < CameraWidget
    protected

    def get_value
      val = FFI::MemoryPointer.new(:int)
      rc = gp_widget_get_value(ptr, val)
      (val.read_int == 1)
    end

    def set_value(toggle)
      val = FFI::MemoryPointer.new(:int)
      val.write_int(toggle ? 1 : 0)
      rc = gp_widget_set_value(ptr, val)
      GPhoto2.check!(rc)
    end
  end
end
