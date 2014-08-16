require 'gphoto2'

# The camera must have a `movie` config key for this to work.
#
# Unlike capturing photos, which typically save to internal memory, videos
# save to the memory card. The next `file_added` event from the camera after
# stopping the recording will contain data pointing to the video file.

GPhoto2::Camera.first do |camera|
  # Start recording.
  camera.update(movie: true)

  # Record for ~10 seconds.
  sleep 10

  # Stop recording.
  camera.update(movie: false)

  # Block until the camera finishes with the file.
  event = camera.wait_for(:file_added)

  # The event data has a camera file that can be saved.
  file = event.data
  file.save
end
