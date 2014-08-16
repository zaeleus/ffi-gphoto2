require 'gphoto2'

# Run and pipe to a video player that can demux raw mjpeg. For example,
#
#     ruby live_view.rb | mpv --demuxer-lavf-format=mjpeg -

# Automatically flush the IO buffer.
STDOUT.sync = true

GPhoto2::Camera.first do |camera|
  loop do
    # Write the preview image to stdout.
    print camera.preview.data
  end
end
