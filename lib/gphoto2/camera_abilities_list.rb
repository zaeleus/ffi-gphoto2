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
  end
end
