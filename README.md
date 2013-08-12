# ffi-gphoto2

**ffi-gphoto2** provides an FFI for common functions in [libgphoto2][1].
It also includes a facade to interact with the library in a more
canonical Ruby way.

## Installation

### Prerequisites

  * Ruby 1.9+
  * libgphoto2 (`brew install libgphoto2`)

### Gem

    $ git clone https://github.com/zaeleus/ffi-gphoto2.git
    $ cd ffi-gphoto2
    $ rake install

## Usage

    require 'gphoto2'

    # list port paths of available devices
    ports = GPhoto2::Port.autodetect
    # => ['usb:250,006']

    # instantiate a new camara from a port
    camera = GPhoto2::Camera.new(ports.first)

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

    # ...and save it in the current working directory
    file.save

[1]: http://www.gphoto.org/
