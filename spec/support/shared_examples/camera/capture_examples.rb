module GPhoto2
  shared_examples_for Camera::Capture do
    describe '#capture' do
      let(:camera) { Camera.new(model, port) }
      let(:path) { double('camera_file_path', folder: 'folder', name: 'name') }

      before do
        allow(camera).to receive(:_capture).and_return(path)
      end

      it 'saves the camera configuration' do
        expect(camera).to receive(:save)
        camera.capture
      end

      it 'returns a new CameraFile' do
        expect(camera).to receive(:_capture)
        expect(camera.capture).to be_kind_of(CameraFile)
      end
    end

    describe '#trigger' do
      let(:camera) { Camera.new(model, port) }

      before do
        allow(camera).to receive(:trigger_capture)
      end

      it 'saves the camera configuration' do
        expect(camera).to receive(:save)
        camera.trigger
      end
    end

    describe '#preview' do
      let(:camera) { Camera.new(model, port) }
      let(:file) { double('camera_file') }

      before do
        allow(camera).to receive(:save)
        allow(camera).to receive(:capture_preview).and_return(file)
      end

      it 'saves the camera configuration' do
        expect(camera).to receive(:save)
        camera.preview
      end

      it 'returns a new CameraFile' do
        expect(camera.preview).to eq(file)
      end
    end
  end
end
