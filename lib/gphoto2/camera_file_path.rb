module GPhoto2
  class CameraFilePath
    attr_reader :ptr

    def initialize
      @ptr = FFI::GPhoto2::CameraFilePath.new
    end

    def name
      ptr[:name].to_s
    end

    def folder
      ptr[:folder].to_s
    end

    def to_ptr
      @ptr
    end
  end
end
