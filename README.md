# ffi-gphoto2


[![Gem Version](https://badge.fury.io/rb/ffi-gphoto2.svg)](https://badge.fury.io/rb/ffi-gphoto2)
[![Build Status](https://travis-ci.org/zaeleus/ffi-gphoto2.svg?branch=master)](https://travis-ci.org/zaeleus/ffi-gphoto2)

**ffi-gphoto2** provides an FFI for common functions in [libgphoto2][gphoto].
It also includes a facade to interact with the library in a more
idiomatic Ruby way.

## Installation

### Prerequisites

  * Ruby >= 2.0
  * libgphoto2 >= 2.5.2
  * libgphoto2_port >= 0.10.1

### Gem

    $ gem install ffi-gphoto2

## Usage

```ruby
require 'gphoto2'

# list available cameras
cameras = GPhoto2::Camera.all
# => [#<GPhoto2::Camera>, ...]

# list found cameras by model and port path
cameras.map { |c| [c.model, c.port] }
# => [['Nikon DSC D5100 (PTP mode)', 'usb:250,006'], ...]

# use the first camera
camera = cameras.first

# ...or more conveniently
camera = GPhoto2::Camera.first

# search by model name
camera = GPhoto2::Camera.where(model: /nikon/i).first

# the above examples require the camera be manually closed when done
camera.close

# pass a block to automatically close the camera
GPhoto2::Camera.first do |camera|
  # ...
end

# check camera abilities (see `FFI::GPhoto2::CameraOperation.symbols`)
camera.can? :capture_image
# => true

# list camera configuration names
camera.config.keys
# => ['autofocusdrive', 'manualfocusdrive', 'controlmode', ...]

# read the current configuration value of an option
camera['expprogram'].value
# => "M"
camera['whitebalance'].value
# => "Automatic"

# list valid choices of a configuration option
camera['whitebalance'].choices
# => ["Automatic", "Daylight", "Fluorescent", "Tungsten", ...]

# check if the configuration has changed
camera.dirty?
# => false

# change camera configuration
camera['iso'] = 800
camera['f-number'] = 'f/4.5'
camera['shutterspeed2'] = '1/30'

# check if the configuration has changed
camera.dirty?
# => true

# apply the new configuration to the device
camera.save

# alternatively, update the camera configuration in one go
camera.update(iso: 200, shutterspeed2: '1/60', 'f-number' => 'f/1.8')

# take a photo
file = camera.capture

# ...and save it to the current working directory
file.save

# ...or to a specific pathname
file.save('/tmp/out.jpg')

# traverse the camera filesystem
folder = camera/'store_00010001/DCIM/100D5100'

# list files
files = folder.files
folder.files.map(&:name)
# => ["DSC_0001.JPG", "DSC_0002.JPG", ...]

# copy a file from the camera
file = files.first
file.save

# ...and then delete it from the camera
file.delete
```

More examples can be found in [`examples/`][examples]. YARD documentation can be
generated using the `rake yard` task or [browsed online][rubydoc].

[gphoto]: http://www.gphoto.org/
[examples]: https://github.com/zaeleus/ffi-gphoto2/tree/master/examples
[rubydoc]: http://www.rubydoc.info/gems/ffi-gphoto2/frames
