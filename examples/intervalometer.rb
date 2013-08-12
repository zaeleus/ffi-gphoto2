require 'gphoto2'

camera = GPhoto2::Camera.first

six_hours = 60 * 60 * 6
stop_time = Time.now + six_hours

# take a photo every 30 seconds for 6 hours
until Time.now >= stop_time
  camera.capture.save
  sleep 30
end
