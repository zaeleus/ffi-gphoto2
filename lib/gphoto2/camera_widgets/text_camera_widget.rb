module GPhoto2
  class TextCameraWidget < CameraWidget
    protected

    def get_value
      val = FFI::MemoryPointer.new(:string)
      val_ptr = FFI::MemoryPointer.new(:pointer)
      val_ptr.write_pointer(val)
      rc = gp_widget_get_value(ptr, val_ptr)
      GPhoto2.check!(rc)
      strPtr = val_ptr.read_pointer
      return strPtr.null? ? nil : strPtr.read_string
    end

    def set_value(text)
      val = FFI::MemoryPointer.from_string(text)
      rc = gp_widget_set_value(ptr, val)
      GPhoto2.check!(rc)
    end
  end
end
