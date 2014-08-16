require 'gphoto2'

six_hours = 60 * 60 * 6
stop_time = Time.now + six_hours

GPhoto2::Camera.first do |camera|
  # Take a photo every 30 seconds for 6 hours.
  until Time.now >= stop_time
    camera.capture.save
    sleep 30
  end
end
