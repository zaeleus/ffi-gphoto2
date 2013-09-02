# ffi-gphoto2

**ffi-gphoto2** provides an FFI for common functions in [libgphoto2][1].
It also includes a facade to interact with the library in a more
canonical Ruby way.

## Installation

### Prerequisites

  * Ruby >= 1.9
  * libgphoto2 >= 2.5.0 (`brew install libgphoto2`)

### Gem

    $ gem install ffi-gphoto2

## Usage

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

    # ...or even search by model name
    camera = GPhoto2::Camera.where(/nikon/i).first

    # list camera configuration names
    camera.config.keys
    # => ['autofocusdrive', 'manualfocusdrive', 'controlmode', ...]

    # read the current configuration value of an option
    camera['whitebalance']
    # => "Automatic"

    # list valid choices of a configuration option
    camera['whitebalance'].choices
    # => ['Automatic', 'Daylight', 'Fluorescent', 'Tungsten', ...]

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

    # apply the new configuration on the device
    camera.save

    # take a photo
    file = camera.capture

    # ...and save it to the current working directory
    file.save

    # traverse the camera filesystem
    folder = camera/'store_00010001/DCIM/100D5100'

    # list files
    files = folder.files
    folder.files.map(&:name)
    => ["DSC_0001.JPG", "DSC_0002.JPG", ...]

    # save a file
    files.first.save

    # close the camera
    camera.finalize

More examples can be found in [`examples/`][2].

[1]: http://www.gphoto.org/
[2]: https://github.com/zaeleus/ffi-gphoto2/tree/master/examples
