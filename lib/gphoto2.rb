require 'logger'

require 'ffi/gphoto2'
require 'ffi/gphoto2_port'

require 'gphoto2/struct'

require 'gphoto2/camera_widgets/camera_widget'
require 'gphoto2/camera_widgets/radio_camera_widget'
require 'gphoto2/camera_widgets/date_camera_widget'
require 'gphoto2/camera_widgets/menu_camera_widget'
require 'gphoto2/camera_widgets/range_camera_widget'
require 'gphoto2/camera_widgets/section_camera_widget'
require 'gphoto2/camera_widgets/text_camera_widget'
require 'gphoto2/camera_widgets/toggle_camera_widget'
require 'gphoto2/camera_widgets/window_camera_widget'

require 'gphoto2/camera_file_info/camera_file_info'
require 'gphoto2/camera_file_info/file_camera_file_info'

require 'gphoto2/camera/capture'
require 'gphoto2/camera/configuration'
require 'gphoto2/camera/event'
require 'gphoto2/camera/filesystem'
require 'gphoto2/camera'

require 'gphoto2/camera_abilities'
require 'gphoto2/camera_abilities_list'
require 'gphoto2/camera_event'
require 'gphoto2/camera_file'
require 'gphoto2/camera_file_path'
require 'gphoto2/camera_folder'
require 'gphoto2/camera_list'
require 'gphoto2/context'
require 'gphoto2/entry'
require 'gphoto2/port'
require 'gphoto2/port_info'
require 'gphoto2/port_info_list'
require 'gphoto2/port_result'
require 'gphoto2/error'

require 'gphoto2/version'

module GPhoto2
  # @return [Logger]
  def self.logger
    @logger ||= Logger.new(STDERR)
  end

  # @param [Integer] rc
  # @return [void]
  # @raise [GPhoto2::Error] when the return code is not {FFI::GPhoto2Port::GP_OK}
  def self.check!(rc)
    logger.debug "#{caller.first} => #{rc}" if ENV['DEBUG']
    return if rc >= FFI::GPhoto2Port::GP_OK
    raise Error.error_from_port_result(rc)
  end
end
