require 'spec_helper'

module GPhoto2
  describe CameraFolder do
    let(:camera) { double('camera') }

    describe '#root?' do
      it 'returns true if the folder is the root' do
        folder = CameraFolder.new(camera, '/')
        expect(folder).to be_root
      end
    end

    describe '#name' do
      context 'when the folder is the root' do
        it 'returns /' do
          folder = CameraFolder.new(camera, '/')
          expect(folder.name).to eq('/')
        end
      end

      context 'when the folder is not the root' do
        it 'returns the current folder name' do
          folder = CameraFolder.new(camera, '/store_00010001/DCIM')
          expect(folder.name).to eq('DCIM')
        end
      end
    end

    describe '#folders' do
      it 'returns a list of subfolders' do
        folder = CameraFolder.new(camera)

        folders = 2.times.map { folder }
        folder.stub(:folder_list_folders).and_return(folders)

        expect(folder.folders).to eq(folders)
      end
    end

    describe '#files' do
      it 'returns a list of files in the folder' do
        folder = CameraFolder.new(camera)

        file = double('camera_file')
        files = 2.times.map { file }
        folder.stub(:folder_list_files).and_return(files)

        expect(folder.files).to eq(files)
      end
    end

    describe '#cd' do
      let(:folder) { CameraFolder.new(camera, '/store_00010001') }

      context 'when passed "."' do
        it 'returns self' do
          expect(folder.cd('.')).to be(folder)
        end
      end

      context 'when passed ".."' do
        it 'returns the parent folder' do
          parent = folder.cd('..')
          expect(parent.path).to eq('/')
        end
      end

      context 'when passed a normal folder name' do
        it 'returns a new folder changed to the new path' do
          child = folder.cd('DCIM')
          expect(child.path).to eq('/store_00010001/DCIM')
        end
      end
    end

    describe '#open' do
      it 'returns a new CameraFile of a file in the folder' do
        file = double('camera_file')
        CameraFile.stub(:new).and_return(file)

        folder = CameraFolder.new(camera)
        expect(folder.open('capt0001.jpg')).to eq(file)
      end
    end

    describe '#up' do
      context 'when the folder is root' do
        it 'returns self' do
          folder = CameraFolder.new(camera, '/')
          expect(folder.up).to be(folder)
        end
      end

      context 'when the folder is not root' do
        it 'returns the parent folder' do
          folder = CameraFolder.new(camera, '/store_00010001')
          expect(folder.up.path).to eq('/')
        end
      end
    end

    describe '#to_s' do
      it 'returns the name of the folder' do
        folder = CameraFolder.new(camera, '/store_00010001')
        expect(folder.to_s).to eq('store_00010001')
      end
    end
  end
end
