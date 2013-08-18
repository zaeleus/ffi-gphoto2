# Run and pipe to a video player that can demux raw mjpeg. For example,
#
#     ruby live_view.rb | mpv --demuxer=+lavf --demuxer-lavf-format=mjpeg --demuxer-lavf-analyzeduration=0.1 -

require 'gphoto2'

# automatically flush the io buffer
STDOUT.sync = true

camera = GPhoto2::Camera.first

begin
  loop do
    # write the preview image to stdout
    print camera.preview.data
  end
ensure
  # make sure to close (or #exit) the camera
  # otherwise, the mirror will stay up
  camera.finalize
end
