# The camera must have a `movie` config key for this to work.
#
# Unlike capturing photos, which typically save to internal memory, videos
# save to the memory card. The next `file_added` event from the camera after
# stopping the recording will contain data pointing to the video file.

require 'gphoto2'

camera = GPhoto2::Camera.first

begin
  # start recording
  camera.update(movie: true)

  # record for ~10 seconds
  sleep 10

  # stop recording
  camera.update(movie: false)

  # block until the camera finishes with the file
  camera.wait_for(:file_added)

  # the event data has a camera file that can be saved
  event.data.save
ensure
  camera.finalize
end
