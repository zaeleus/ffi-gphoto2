require 'gphoto2'

# Take a photo every 10 seconds for 2 hours.

interval = 10 # seconds
two_hours = 60 * 60 * 2 # (2 hours)
stop_time = Time.now + two_hours

GPhoto2::Camera.first do |camera|
  until Time.now >= stop_time
    camera.capture.save
    sleep interval
  end
end
