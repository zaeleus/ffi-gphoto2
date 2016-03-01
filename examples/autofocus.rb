require 'gphoto2'

# Capture an image only after successfully autofocusing.
#
# Typically, if the camera fails to autofocus, updating the `autofocusdrive`
# key will throw an "Unspecified error (-1)". This catches the exception and
# continues to autofocus until it is successful.

GPhoto2::Camera.first do |camera|
  begin
    camera.update(autofocusdrive: true)
  rescue GPhoto2::Error
    puts "autofocus failed... retrying"
    camera.reload
    retry
  ensure
    camera.update(autofocusdrive: false)
  end

  camera.capture
end
