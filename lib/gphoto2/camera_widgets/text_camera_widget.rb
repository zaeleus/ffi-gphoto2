module GPhoto2
  class TextCameraWidget < CameraWidget
    protected

    def get_value
      val_ptr = FFI::MemoryPointer.new(:pointer)

      rc = gp_widget_get_value(ptr, val_ptr)
      GPhoto2.check!(rc)

      val_ptr = val_ptr.read_pointer
      val_ptr.null? ? nil : val_ptr.read_string
    end

    def set_value(text)
      val = FFI::MemoryPointer.from_string(text.to_s)
      rc = gp_widget_set_value(ptr, val)
      GPhoto2.check!(rc)
    end
  end
end
