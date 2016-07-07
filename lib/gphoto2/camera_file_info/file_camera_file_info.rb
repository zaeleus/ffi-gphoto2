module GPhoto2
  class FileCameraFileInfo < CameraFileInfo
    # @return [Integer, nil]
    def width
      fetch(:width)
    end

    # @return [Integer, nil]
    def height
      fetch(:height)
    end

    # @return [Boolean, nil]
    def readable?
      permissions = fetch(:permissions)
      (permissions & CameraFilePermissions[:read]) != 0 if permissions
    end

    # @return [Boolean, nil]
    def deletable?
      permissions = fetch(:permissions)
      (permissions & CameraFilePermissions[:delete]) != 0 if permissions
    end

    # @return [Time, nil] the last modification time
    def mtime
      Time.at(ptr[:mtime]) if has_field?(:mtime)
    end
  end
end
