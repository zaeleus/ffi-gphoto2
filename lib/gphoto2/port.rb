module GPhoto2
  class Port
    def self.autodetect
      context = Context.new

      camera_abilities_list = CameraAbilitiesList.new(context)
      camera_list = camera_abilities_list.detect

      entries = camera_list.to_a

      context.finalize

      entries
    end
  end
end
