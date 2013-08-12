module GPhoto2
  class DateCameraWidget < CameraWidget
    protected

    def get_value
      val = FFI::MemoryPointer.new(:int)
      rc = gp_widget_get_value(ptr, val)
      GPhoto2.check!(rc)
      Time.at(val.read_int).utc
    end

    def set_value(date)
      val = FFI::MemoryPointer.new(:int)
      val.write_int(date.to_i)
      rc = gp_widget_set_value(ptr, val)
      GPhoto2.check!(rc)
    end
  end
end
