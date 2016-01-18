require 'gphoto2'

# Captures a single photo and saves it to the current working directory.

GPhoto2::Camera.first do |camera|
  file = camera.capture
  file.save
end
