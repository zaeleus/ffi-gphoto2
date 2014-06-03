require 'spec_helper'

module GPhoto2
  describe CameraFilePath do
    let(:name) { 'capt0001.jpg' }
    let(:folder) { '/' }

    before do
      allow_any_instance_of(CameraFilePath).to receive(:name).and_return(name)
      allow_any_instance_of(CameraFilePath).to receive(:folder).and_return(folder)
    end

    describe '#name' do
      it 'returns the name of the file' do
        path = CameraFilePath.new
        expect(path.name).to eq(name)
      end
    end

    describe '#folder' do
      it 'returns the folder that contains the file' do
        path = CameraFilePath.new
        expect(path.folder).to eq(folder)
      end
    end
  end
end
