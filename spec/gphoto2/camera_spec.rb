require 'spec_helper'

module GPhoto2
  describe Camera do
    let(:port) { double('entry', name: 'model', value: 'usb:250,006') }

    describe '.all' do
      let(:abilities_list) { double('camera_abilities_list') }
      let(:camera_list) { double('camera_list') }
      let(:camera) { Camera.new(port) }

      before do
        Context.stub(:stub)
        CameraAbilitiesList.stub(:new).and_return(abilities_list)
        abilities_list.stub(:detect).and_return(camera_list)
        camera_list.stub(:to_a).and_return([port])
      end

      it 'returns a list of device entries' do
        list = Camera.all
        expect(list).to be_kind_of(Array)
        expect(list.first).to be_kind_of(Camera)
      end
    end

    describe '.first' do
      context 'when devices are automatically detected' do
        it 'returns a new Camera using the first entry' do
          camera = Camera.new(port)
          Camera.stub(:all).and_return([camera])
          expect(Camera.first).to be_kind_of(Camera)
        end
      end

      context 'when no devices are detected' do
        it 'raises a RuntimeError' do
          Camera.stub(:all).and_return([])
          expect { Camera.first }.to raise_error(RuntimeError)
        end
      end
    end

    describe '.open' do
      let(:camera) { double('camera') }
      before { Camera.stub(:new).and_return(camera) }

      context 'when a block is given' do
        it 'yeilds a new camera instance' do
          expect(Camera).to receive(:open).and_yield(camera)
          Camera.open(port) { |c| }
        end

        it 'finalizes the camera when the block terminates' do
          expect(camera).to receive(:finalize)
          Camera.open(port) { |c| }
        end
      end

      context 'when no block is given' do
        it 'returns a new camera instance' do
           expect(Camera.open(port)).to eq(camera)
        end
      end
    end

    describe '.where' do
      it 'filters all detected cameras by model' do
        cameras = %w[cheese toast wine].map { |model| double('camera', model: model) }
        Camera.stub(:all).and_return(cameras)
        expect(Camera.where(/e/)).to match_array([cameras[0], cameras[2]])
      end
    end

    describe '#exit' do
      it 'closes the camera connection' do
        camera = Camera.new(port)
        camera.stub(:_exit)
        expect(camera).to receive(:_exit)
        camera.exit
      end
    end

    describe '#capture' do
      let(:camera) { Camera.new(port) }
      let(:path) { double('camera_file_path', folder: 'folder', name: 'name') }

      before do
        camera.stub(:_capture).and_return(path)
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

    describe '#preview' do
      let(:camera) { Camera.new(port) }
      let(:file) { double('camera_file') }

      before do
        camera.stub(:save)
        camera.stub(:capture_preview).and_return(file)
      end

      it 'saves the camera configuration' do
        expect(camera).to receive(:save)
        camera.preview
      end

      it 'returns a new CameraFile' do
        expect(camera.preview).to eq(file)
      end
    end

    describe '#wait' do
      let(:camera) { Camera.new(port) }
      let(:event) { :capture_complete }

      before do
        camera.stub(:wait_for_event).and_return(event)
      end

      it 'waits for a camera event' do
        expect(camera).to receive(:wait_for_event)
        camera.wait
      end

      it 'returns an event symbol' do
        expect(camera.wait).to eq(event)
      end
    end

    describe '#window' do
      let(:camera) { Camera.new(port) }
      let(:window) { double('camera_widget') }

      it 'always returns the same CameraWidget instance' do
        camera.stub(:get_config).and_return(window)
        expect(camera.window).to eq(window)
        expect(camera.window).to eq(window)
      end
    end

    describe '#config' do
      it 'returns a map of configuration widgets' do
        camera = Camera.new(port)
        window = double('camera_widget')
        camera.stub(:window).and_return(window)
        window.stub(:flatten).and_return({ 'iso' => window })

        expect(camera.config).to eq({ 'iso' => window })
      end
    end

    describe '#filesystem' do
      let(:camera) { Camera.new(port) }

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
        camera = Camera.new(port)
        camera.stub(:file_get)
        expect(camera).to receive(:file_get)
        camera.file(double('camera_file'))
      end
    end

    describe '#[]' do
      let(:window) { double('camera_widget') }

      let(:camera) do
        camera = Camera.new(port)
        camera.stub(:config).and_return({ 'iso' => window })
        camera
      end

      context 'when the specified key exists' do
        it 'returns a CameraWidget' do
          expect(camera['iso']).to eq(window)
        end
      end

      context 'when the specified key does not exist' do
        it 'returns nil' do
          expect(camera['shutterspeed2']).to be_nil
        end
      end
    end

    describe '#[]=' do
      let(:window) do
        window = double('camera_widget')
        expect(window).to receive(:value=).with(400)
        window
      end

      let(:camera) do
        camera = Camera.new(port)
        camera.stub(:[]).and_return(window)
        camera
      end

      it "set a widget's value" do
        camera['iso'] = 400
      end

      it 'marks the camera as dirty' do
        camera['iso'] = 400
        expect(camera).to be_dirty
      end

      it 'returns the passed value' do
        expect(camera['iso'] = 400).to eq(400)
      end
    end

    describe '#dirty?' do
      context 'when the configuration changed' do
        it 'returns true' do
          camera = Camera.new(port)
          camera.stub_chain(:[], :value=)

          camera['iso'] = 400

          expect(camera).to be_dirty
        end
      end

      context 'when the configuration has not changed' do
        it 'returns false' do
          camera = Camera.new(port)
          expect(camera).not_to be_dirty 
        end
      end
    end

    describe '#save' do
      let(:camera) do
        camera = Camera.new(port)
        camera.stub_chain(:[], :value=)
        camera.stub(:set_config)
        camera
      end

      context 'when the camera is marked as dirty' do
        it 'returns true' do
          camera['iso'] = 400
          expect(camera.save).to be_true
        end

        it 'marks the camera as not dirty' do
          camera['iso'] = 400
          camera.save
          expect(camera).not_to be_dirty
        end
      end

      context 'when the camera is not marked as dirty' do
        it 'returns false' do
          expect(camera.save).to be_false
        end
      end
    end
  end
end
