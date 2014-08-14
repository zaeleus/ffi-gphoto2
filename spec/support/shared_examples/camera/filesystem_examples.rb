module GPhoto2
  shared_examples_for Camera::Filesystem do
    describe '#filesystem' do
      let(:camera) { Camera.new(model, port) }

      context 'when a path is passed' do
        let(:path) { '/store_00010001' }

        it 'assumes the path is absolute' do
          fs = camera.filesystem(path[1..-1])
          expect(fs.path).to eq(path)
        end

        it 'returns a folder at the path that was passed' do
          fs = camera.filesystem(path)
          expect(fs.path).to eq(path)
        end
      end

      context 'when no path is passed' do
        it 'returns a folder at the root of the filesystem' do
          fs = camera.filesystem
          expect(fs.path).to eq('/')
        end
      end
    end

    describe '#file' do
      it 'retrieves a file from the camera' do
        camera = Camera.new(model, port)
        allow(camera).to receive(:file_get)
        expect(camera).to receive(:file_get)
        camera.file(double('camera_file'))
      end
    end

    describe '#delete' do
      it 'deletes a file from the camera' do
        camera = Camera.new(model, port)
        allow(camera).to receive(:file_delete)
        expect(camera).to receive(:file_delete)
        camera.delete(double('camera_file'))
      end
    end
  end
end
