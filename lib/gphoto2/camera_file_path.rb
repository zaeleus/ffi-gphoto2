module GPhoto2
  class CameraFilePath
    include GPhoto2::Struct

    def initialize(ptr = nil)
      @ptr = ptr || FFI::GPhoto2::CameraFilePath.new
    end

    def name
      ptr[:name].to_s
    end

    def folder
      ptr[:folder].to_s
    end
  end
end
