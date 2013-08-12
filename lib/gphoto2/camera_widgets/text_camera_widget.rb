module GPhoto2
  class TextCameraWidget < CameraWidget
    protected

    def get_value
      val = FFI::MemoryPointer.new(:string)
      val_ptr = FFI::MemoryPointer.new(:pointer)
      val_ptr.write_pointer(val)
      rc = gp_widget_get_value(ptr, val_ptr)
      GPhoto2.check!(rc)
      val_ptr.read_pointer.read_string
    end
  end
end
