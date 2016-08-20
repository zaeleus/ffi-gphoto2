module GPhoto2
  # @abstract
  class CameraWidget
    include FFI::GPhoto2
    include GPhoto2::Struct

    # @param [FFI::GPhoto2::CameraWidget] ptr
    # @param [GPhoto2::CameraWidget] parent
    def self.factory(ptr, parent = nil)
      # ptr fields are supposed to be private, but we ignore that here
      type = ptr[:type].to_s.split('_').last.capitalize
      klass = GPhoto2.const_get("#{type}CameraWidget")
      klass.new(ptr, parent)
    end

    # @param [FFI::GPhoto2::CameraWidget] ptr
    # @param [GPhoto2::CameraWidget] parent
    def initialize(ptr, parent = nil)
      @ptr = ptr
      @parent = parent
    end

    # @return [void]
    def finalize
      free
    end
    alias_method :close, :finalize

    # @return [String]
    def label
      get_label
    end

    # @return [String]
    def name
      get_name
    end

    # @return [Object]
    def value
      get_value
    end

    # @return [Object]
    def value=(value)
      set_value(value)
      value
    end

    # @return [CameraWidgetType]
    def type
      get_type
    end

    # @return [Array<GPhoto2::CameraWidget>]
    def children
      count_children.times.map { |i| get_child(i) }
    end

    # @param [Hash<String,GPhoto2::CameraWidget>] map
    # @return [Hash<String,GPhoto2::CameraWidget>]
    def flatten(map = {})
      case type
      when :window, :section
        children.each { |child| child.flatten(map) }
      else
        map[name] = self
      end

      map
    end

    # @return [String]
    def to_s
      value.to_s
    end

    protected

    def get_value
      raise NotImplementedError
    end

    def set_value(value)
      raise NotImplementedError
    end

    private

    def free
      rc = gp_widget_free(ptr)
      GPhoto2.check!(rc)
    end

    def get_name
      str_ptr = FFI::MemoryPointer.new(:pointer)

      rc = gp_widget_get_name(ptr, str_ptr)
      GPhoto2.check!(rc)

      str_ptr = str_ptr.read_pointer
      str_ptr.null? ? nil : str_ptr.read_string
    end

    def get_type
      # assume CameraWidgetType is an int
      type = FFI::MemoryPointer.new(:int)
      rc = gp_widget_get_type(ptr, type)
      GPhoto2.check!(rc)
      CameraWidgetType[type.read_int]
    end

    def get_label
      str_ptr = FFI::MemoryPointer.new(:pointer)

      rc = gp_widget_get_label(ptr, str_ptr)
      GPhoto2.check!(rc)

      str_ptr = str_ptr.read_pointer
      str_ptr.null? ? nil : str_ptr.read_string
    end

    def count_children
      count = rc = gp_widget_count_children(ptr)
      GPhoto2.check!(rc)
      count
    end

    def get_child(index)
      widget_ptr = FFI::MemoryPointer.new(:pointer)
      rc = gp_widget_get_child(ptr, index, widget_ptr)
      GPhoto2.check!(rc)
      widget = FFI::GPhoto2::CameraWidget.new(widget_ptr.read_pointer)
      CameraWidget.factory(widget, self)
    end
  end
end
