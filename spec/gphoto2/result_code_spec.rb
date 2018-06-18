require 'spec_helper'

module GPhoto2
  describe :check! do
    it 'should not raise an exception if the result code is 0' do
      GPhoto2.check!(0)
    end

    it 'should raise error types mapped from FFI::GPhoto2Port and FFI::GPhoto2::Result constants' do

      # Port result errors
      expect{GPhoto2.check!(-1)}.to raise_error(GPhoto2::Error::GP_ERROR)
      expect{GPhoto2.check!(-2)}.to raise_error(GPhoto2::Error::GP_ERROR_BAD_PARAMETERS)
      expect{GPhoto2.check!(-3)}.to raise_error(GPhoto2::Error::GP_ERROR_NO_MEMORY)
      expect{GPhoto2.check!(-4)}.to raise_error(GPhoto2::Error::GP_ERROR_LIBRARY)
      expect{GPhoto2.check!(-5)}.to raise_error(GPhoto2::Error::GP_ERROR_UNKNOWN_PORT)
      expect{GPhoto2.check!(-6)}.to raise_error(GPhoto2::Error::GP_ERROR_NOT_SUPPORTED)
      expect{GPhoto2.check!(-7)}.to raise_error(GPhoto2::Error::GP_ERROR_IO)
      expect{GPhoto2.check!(-8)}.to raise_error(GPhoto2::Error::GP_ERROR_FIXED_LIMIT_EXCEEDED)
      expect{GPhoto2.check!(-10)}.to raise_error(GPhoto2::Error::GP_ERROR_TIMEOUT)
      expect{GPhoto2.check!(-20)}.to raise_error(GPhoto2::Error::GP_ERROR_IO_SUPPORTED_SERIAL)
      expect{GPhoto2.check!(-21)}.to raise_error(GPhoto2::Error::GP_ERROR_IO_SUPPORTED_USB)
      expect{GPhoto2.check!(-31)}.to raise_error(GPhoto2::Error::GP_ERROR_IO_INIT)
      expect{GPhoto2.check!(-34)}.to raise_error(GPhoto2::Error::GP_ERROR_IO_READ)
      expect{GPhoto2.check!(-35)}.to raise_error(GPhoto2::Error::GP_ERROR_IO_WRITE)
      expect{GPhoto2.check!(-37)}.to raise_error(GPhoto2::Error::GP_ERROR_IO_UPDATE)
      expect{GPhoto2.check!(-41)}.to raise_error(GPhoto2::Error::GP_ERROR_IO_SERIAL_SPEED)
      expect{GPhoto2.check!(-51)}.to raise_error(GPhoto2::Error::GP_ERROR_IO_USB_CLEAR_HALT)
      expect{GPhoto2.check!(-52)}.to raise_error(GPhoto2::Error::GP_ERROR_IO_USB_FIND)
      expect{GPhoto2.check!(-53)}.to raise_error(GPhoto2::Error::GP_ERROR_IO_USB_CLAIM)
      expect{GPhoto2.check!(-60)}.to raise_error(GPhoto2::Error::GP_ERROR_IO_LOCK)
      expect{GPhoto2.check!(-70)}.to raise_error(GPhoto2::Error::GP_ERROR_HAL)

      # Other errors
      expect{GPhoto2.check!(-102)}.to raise_error(GPhoto2::Error::GP_ERROR_CORRUPTED_DATA)
      expect{GPhoto2.check!(-103)}.to raise_error(GPhoto2::Error::GP_ERROR_FILE_EXISTS)
      expect{GPhoto2.check!(-105)}.to raise_error(GPhoto2::Error::GP_ERROR_MODEL_NOT_FOUND)
      expect{GPhoto2.check!(-107)}.to raise_error(GPhoto2::Error::GP_ERROR_DIRECTORY_NOT_FOUND)
      expect{GPhoto2.check!(-108)}.to raise_error(GPhoto2::Error::GP_ERROR_FILE_NOT_FOUND)
      expect{GPhoto2.check!(-109)}.to raise_error(GPhoto2::Error::GP_ERROR_DIRECTORY_EXISTS)
      expect{GPhoto2.check!(-110)}.to raise_error(GPhoto2::Error::GP_ERROR_CAMERA_BUSY)
      expect{GPhoto2.check!(-111)}.to raise_error(GPhoto2::Error::GP_ERROR_PATH_NOT_ABSOLUTE)
      expect{GPhoto2.check!(-112)}.to raise_error(GPhoto2::Error::GP_ERROR_CANCEL)
      expect{GPhoto2.check!(-113)}.to raise_error(GPhoto2::Error::GP_ERROR_CAMERA_ERROR)
      expect{GPhoto2.check!(-114)}.to raise_error(GPhoto2::Error::GP_ERROR_OS_FAILURE)
      expect{GPhoto2.check!(-115)}.to raise_error(GPhoto2::Error::GP_ERROR_NO_SPACE)
    end
  end
end
