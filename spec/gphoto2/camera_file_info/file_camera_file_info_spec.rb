require 'spec_helper'
require 'ostruct'

module GPhoto2
  describe FileCameraFileInfo do
    it_behaves_like CameraFileInfo

    let(:camera_file_info_file) do
      OpenStruct.new(
        fields: 0xff,
        status: :not_downloaded,
        size: 7355608,
        type: 'image/jpeg',
        width: 4928,
        height: 3264,
        permissions: 0xff,
        mtime: Time.at(1467863342)
      )
    end

    describe '#width' do
      it 'returns the width of the file' do
        info = FileCameraFileInfo.new(camera_file_info_file)
        expect(info.width).to eq(4928)
      end
    end

    describe '#height' do
      it 'returns the height of the file' do
        info = FileCameraFileInfo.new(camera_file_info_file)
        expect(info.height).to eq(3264)
      end
    end

    describe '#readable?' do
      it 'returns whether the file is readable' do
        info = FileCameraFileInfo.new(camera_file_info_file)
        expect(info.readable?).to be(true)
      end
    end

    describe '#deletable?' do
      it 'returns whether the file is deletable' do
        info = FileCameraFileInfo.new(camera_file_info_file)
        expect(info.deletable?).to be(true)
      end
    end

    describe '#mtime' do
      it 'returns the last modification time of the file' do
        info = FileCameraFileInfo.new(camera_file_info_file)
        expect(info.mtime).to eq(Time.at(1467863342))
      end
    end
  end
end
