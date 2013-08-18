require 'spec_helper'

module GPhoto2
  describe CameraFile do
    let(:camera) { double('camera') }
    let(:camera_file_path) { double('camera_file_path', name: 'capt0001.jpg') }
    let(:data_and_size) { ['data', 384] }

    before do
      CameraFile.any_instance.stub(:new)
      CameraFile.any_instance.stub(:get_data_and_size).and_return(data_and_size)
    end

    describe '#save' do
      let(:file) { CameraFile.new(camera, camera_file_path) }
      let(:data) { data_and_size.first }

      before do
        File.stub(:binwrite)
      end

      context 'when a pathname is passed' do
        it 'saves the data to the passed pathname' do
          pathname = '/tmp/capt0100.jpg'
          expect(File).to receive(:binwrite).with(pathname, data)
          file.save(pathname)
        end
      end

      context 'when no arguments are passed' do
        it 'saves the data to the working directory using file path name' do
          pathname = camera_file_path.name
          expect(File).to receive(:binwrite).with(pathname, data)
          file.save
        end
      end
    end

    describe '#data' do
      it 'returns the data of the camera file' do
        file = CameraFile.new(camera, camera_file_path)
        file.stub(:data_and_size).and_return(data_and_size)
        expect(file.data).to eq(data_and_size.first)
      end
    end

    describe '#size' do
      it 'returns the size of the camera file' do
        file = CameraFile.new(camera, camera_file_path)
        file.stub(:data_and_size).and_return(data_and_size)
        expect(file.size).to eq(data_and_size.last)
      end
    end
  end
end
