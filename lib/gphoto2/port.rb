module GPhoto2
  class Port
    def self.autodetect
      context = Context.new

      camera_abilities_list = CameraAbilitiesList.new(context)
      camera_list = camera_abilities_list.detect

      ports = camera_list.to_a.map(&:value)

      context.finalize

      ports
    end
  end
end
