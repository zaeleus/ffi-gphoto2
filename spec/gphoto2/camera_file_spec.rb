require 'spec_helper'

module GPhoto2
  describe CameraFile do
    let(:camera) { double('camera') }
    let(:folder) { '/store_00010001' }
    let(:name) { 'capt0100.jpg' }
    let(:data_and_size) { ['data', 384] }

    before do
      allow_any_instance_of(CameraFile).to receive(:new)
      allow_any_instance_of(CameraFile).to receive(:data_and_size).and_return(data_and_size)
    end

    describe '#preview' do
      context 'when a folder and file are set' do
        it 'returns false' do
          file = CameraFile.new(camera, folder, name)
          expect(file.preview?).to be(false)
        end
      end

      context 'when no folder or file is set' do
        it 'returns true' do
          file = CameraFile.new(camera)
          expect(file.preview?).to be(true)
        end
      end
    end

    describe '#save' do
      let(:file) { CameraFile.new(camera, folder, name) }
      let(:data) { data_and_size.first }

      before do
        allow(File).to receive(:binwrite)
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
          expect(File).to receive(:binwrite).with(name, data)
          file.save
        end
      end
    end

    describe '#delete' do
      it 'delegates the deletion of the file to the camera' do
        file = CameraFile.new(camera, folder, name)
        expect(camera).to receive(:delete).with(file)
        file.delete
      end
    end

    describe '#data' do
      it 'returns the data of the camera file' do
        file = CameraFile.new(camera, folder, name)
        allow(file).to receive(:data_and_size).and_return(data_and_size)
        expect(file.data).to eq(data_and_size.first)
      end
    end

    describe '#size' do
      it 'returns the size of the camera file' do
        file = CameraFile.new(camera, folder, name)
        allow(file).to receive(:data_and_size).and_return(data_and_size)
        expect(file.size).to eq(data_and_size.last)
      end
    end

    describe '#info' do
      context 'the file is a preview' do
        it 'returns nil' do
          file = CameraFile.new(camera)
          expect(file.info).to be(nil)
        end
      end

      context 'the file is a file' do
        it 'it returns an instance of FileCameraFileInfo' do
          file = CameraFile.new(camera, folder, name)
          allow(file).to receive(:get_info).and_return(FileCameraFileInfo.new(nil))
          expect(file.info).to be_kind_of(FileCameraFileInfo)
        end
      end
    end
  end
end
