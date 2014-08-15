module GPhoto2
  class Camera
    module Filesystem
      # @example
      #   # Get a list of filenames in a path.
      #   folder = camera/'store_00010001/DCIM/100D5100'
      #   folder.files.map(&:name)
      #   # => ["DSC_0001.JPG", "DSC_0002.JPG", ...]
      #
      # @param [String] root
      # @return [CameraFolder]
      def filesystem(root = '/')
        root = "/#{root}" if root[0] != '/'
        CameraFolder.new(self, root)
      end
      alias_method :/, :filesystem

      # @param [CameraFile] file
      # @return [CameraFile]
      def file(file)
        file_get(file)
      end

      # @param [CameraFile] file
      # @return [void]
      def delete(file)
        file_delete(file)
      end

      private

      def file_get(file, type = :normal)
        rc = gp_camera_file_get(ptr, file.folder, file.name, type, file.ptr, context.ptr)
        GPhoto2.check!(rc)
        file
      end

      def file_delete(file)
        rc = gp_camera_file_delete(ptr, file.folder, file.name, context.ptr)
        GPhoto2.check!(rc)
      end
    end
  end
end
