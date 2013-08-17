module GPhoto2
  class CameraAbilitiesList
    include FFI::GPhoto2

    attr_reader :ptr

    def initialize(context)
      @context = context
      new
      load
    end

    def detect
      _detect
    end

    def lookup_model(model)
      _lookup_model(model)
    end
    alias_method :index, :lookup_model

    def at(index)
      CameraAbilities.new(self, index)
    end
    alias_method :[], :at

    def to_ptr
      @ptr
    end

    private

    def new
      ptr = FFI::MemoryPointer.new(FFI::GPhoto2::CameraAbilitiesList)
      rc = gp_abilities_list_new(ptr)
      GPhoto2.check!(rc)
      @ptr = FFI::GPhoto2::CameraAbilitiesList.new(ptr.read_pointer)
    end

    def load
      rc = gp_abilities_list_load(ptr, @context.ptr)
      GPhoto2.check!(rc)
    end

    def _detect
      port_info_list = PortInfoList.new
      camera_list = CameraList.new

      rc = gp_abilities_list_detect(ptr,
                                    port_info_list.ptr,
                                    camera_list.ptr,
                                    @context.ptr)
      GPhoto2.check!(rc)

      camera_list
    end

    def _lookup_model(model)
      index = rc = gp_abilities_list_lookup_model(ptr, model)
      GPhoto2.check!(rc)
      index
    end
  end
end
