module GPhoto2
  class CameraWidget
    include FFI::GPhoto2

    attr_reader :ptr

    def self.factory(ptr, parent = nil)
      # ptr fields are supposed to be private, but we ignore that here
      type = ptr[:type].to_s.split('_').last.capitalize
      klass = GPhoto2.const_get("#{type}CameraWidget")
      klass.new(ptr, parent)
    end

    def initialize(ptr, parent = nil)
      @ptr = ptr
      @parent = parent
    end

    def finalize
      free
    end
    alias_method :close, :finalize

    def label
      get_label
    end

    def name
      get_name
    end

    def value
      get_value
    end

    def value=(value)
      set_value(value)
      value
    end

    def type
      get_type
    end

    def children
      count_children.times.map { |i| get_child(i) }
    end

    def flatten(map = {})
      case type
      when :window, :section
        children.each { |child| child.flatten(map) }
      when :menu
        # noop
      else
        map[name] = self
      end

      map
    end

    def to_s
      value.to_s
    end

    def to_ptr
      @ptr
    end

    private

    def free
      rc = gp_widget_free(ptr)
      GPhoto2.check!(rc)
    end

    def get_name
      str = FFI::MemoryPointer.new(:string)
      str_ptr = FFI::MemoryPointer.new(:pointer)
      str_ptr.write_pointer(str)

      rc = gp_widget_get_name(ptr, str_ptr)
      GPhoto2.check!(rc)

      str_ptr = str_ptr.read_pointer
      str_ptr.null? ? nil : str_ptr.read_string
    end

    def get_value
      raise NotImplementedError
    end

    def set_value(value)
      raise NotImplementedError
    end

    def get_type
      # assume CameraWidgetType is an int
      type = FFI::MemoryPointer.new(:int)
      rc = gp_widget_get_type(ptr, type)
      GPhoto2.check!(rc)
      CameraWidgetType[type.read_int]
    end

    def get_label
      str = FFI::MemoryPointer.new(:string)
      str_ptr = FFI::MemoryPointer.new(:pointer)
      str_ptr.write_pointer(str)

      rc = gp_widget_get_type(ptr, str_ptr)

      str_ptr = str_ptr.read_pointer
      str_ptr.null? ? nil : str_ptr.read_string
    end

    def count_children
      rc = gp_widget_count_children(ptr)
      GPhoto2.check!(rc)
      rc
    end

    def get_child(index)
      widget_ptr = FFI::MemoryPointer.new(FFI::GPhoto2::CameraWidget)
      rc = gp_widget_get_child(ptr, index, widget_ptr)
      GPhoto2.check!(rc)
      widget = FFI::GPhoto2::CameraWidget.new(widget_ptr.read_pointer)
      CameraWidget.factory(widget, self)
    end
  end
end
