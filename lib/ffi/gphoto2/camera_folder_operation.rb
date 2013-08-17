module FFI
  module GPhoto2
    # gphoto2/gphoto2-abilities-list.h
    CameraFolderOperation = enum :none, 0,
                                 :delete_all, 1 << 0,
                                 :put_file, 1 << 1,
                                 :make_dir, 1 << 2,
                                 :remove_dir, 1 << 3
  end
end
