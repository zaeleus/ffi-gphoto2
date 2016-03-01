require 'gphoto2'

# This example is limited to Nikon cameras with a continuous burst mode.

# The number of frames to capture.
N = 3

GPhoto2::Camera.first do |camera|
  # Set the camera to continuous burst mode.
  camera.update(capturemode: 'Burst', burstnumber: N)

  # Use `#trigger` instead of `#capture` so the data remains in the camera
  # buffer.
  camera.trigger

  # Wait for the camera to process all the images.
  queue = N.times.map do
    event = camera.wait_for(:file_added)

    # The event data contains a `CameraFile` when the `:file_added` event is
    # triggered.
    event.data
  end

  # Save all the images to the current working directory.
  queue.each(&:save)
end
