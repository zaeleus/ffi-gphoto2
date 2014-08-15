module GPhoto2
  class CameraFilePath
    include GPhoto2::Struct

    def initialize(ptr = nil)
      @ptr = ptr || FFI::GPhoto2::CameraFilePath.new
    end

    # @return [String]
    def name
      ptr[:name].to_s
    end

    # @return [String]
    def folder
      ptr[:folder].to_s
    end
  end
end
