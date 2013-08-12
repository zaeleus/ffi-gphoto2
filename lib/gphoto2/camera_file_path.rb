module GPhoto2
  class CameraFilePath
    attr_reader :ptr

    def initialize
      @ptr = FFI::GPhoto2::CameraFilePath.new
    end

    def name
      @ptr[:name]
    end

    def folder
      @ptr[:folder]
    end

    def to_ptr
      @ptr
    end
  end
end
