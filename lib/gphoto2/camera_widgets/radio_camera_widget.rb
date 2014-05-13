module GPhoto2
  class RadioCameraWidget < CameraWidget
    def choices
      count_choices.times.map { |i| get_choice(i) }
    end

    protected

    def get_value
      val = FFI::MemoryPointer.new(:string)
      val_ptr = FFI::MemoryPointer.new(:pointer)
      val_ptr.write_pointer(val)

      rc = gp_widget_get_value(ptr, val_ptr)
      GPhoto2.check!(rc)

      val_ptr = val_ptr.read_pointer
      val_ptr.null? ? nil : val_ptr.read_string
    end

    def set_value(value)
      val = FFI::MemoryPointer.from_string(value.to_s)
      rc = gp_widget_set_value(ptr, val)
      GPhoto2.check!(rc)
    end

    private

    def count_choices
      rc = gp_widget_count_choices(ptr)
      GPhoto2.check!(rc)
      rc
    end

    def get_choice(i)
      val = FFI::MemoryPointer.new(:string)
      val_ptr = FFI::MemoryPointer.new(:pointer)
      val_ptr.write_pointer(val)

      rc = gp_widget_get_choice(ptr, i, val_ptr)
      GPhoto2.check!(rc)

      val_ptr = val_ptr.read_pointer
      val_ptr.null? ? nil : val_ptr.read_string
    end
  end
end
