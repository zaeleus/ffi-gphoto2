module GPhoto2
  class CameraAbilities
    include FFI::GPhoto2
    include GPhoto2::Struct

    # @param [String] model the name of the device
    # @return [GPhoto2::CameraAbilities]
    def self.find(model)
      context = Context.new

      camera_abilities_list = CameraAbilitiesList.new(context)
      index = camera_abilities_list.lookup_model(model)
      abilities = camera_abilities_list[index]

      context.finalize

      abilities
    end

    # @param [GPhoto2::CameraAbilitiesList] camera_abilities_list
    # @param [Integer] index
    def initialize(camera_abilities_list, index)
      @camera_abilities_list = camera_abilities_list
      @index = index
      get_abilities
    end

    # @return [Object]
    def [](field)
      ptr[field]
    end

    # @return [Integer] a bit field of supported operations
    def operations
      if self[:operations] == :none
        CameraOperation[:none]
      else
        self[:operations]
      end
    end

    private

    def get_abilities
      ptr = FFI::GPhoto2::CameraAbilities.new
      rc = gp_abilities_list_get_abilities(@camera_abilities_list.ptr,
                                           @index,
                                           ptr)
      GPhoto2.check!(rc)
      @ptr = ptr
    end
  end
end
