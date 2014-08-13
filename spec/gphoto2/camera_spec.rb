require 'spec_helper'

module GPhoto2
  describe Camera do
    let(:model) { 'Nikon DSC D5100 (PTP mode)' }
    let(:port) { 'usb:250,006' }

    it_behaves_like Camera::Configuration
    it_behaves_like Camera::Filesystem

    describe '.all' do
      let(:abilities_list) { double('camera_abilities_list') }
      let(:camera_list) { double('camera_list') }
      let(:camera) { Camera.new(model, port) }

      before do
        allow(CameraAbilitiesList).to receive(:new).and_return(abilities_list)
        allow(abilities_list).to receive(:detect).and_return(camera_list)
        allow(camera_list).to receive_message_chain(:to_a, :map).and_return([camera])
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
          camera = Camera.new(model, port)
          allow(Camera).to receive(:all).and_return([camera])
          expect(Camera.first).to be_kind_of(Camera)
        end
      end

      context 'when no devices are detected' do
        it 'raises a RuntimeError' do
          allow(Camera).to receive(:all).and_return([])
          expect { Camera.first }.to raise_error(RuntimeError)
        end
      end
    end

    describe '.open' do
      let(:camera) { double('camera') }
      before { allow(Camera).to receive(:new).and_return(camera) }

      context 'when a block is given' do
        it 'yeilds a new camera instance' do
          expect(Camera).to receive(:open).and_yield(camera)
          Camera.open(model, port) { |c| }
        end

        it 'finalizes the camera when the block terminates' do
          expect(camera).to receive(:finalize)
          Camera.open(model, port) { |c| }
        end
      end

      context 'when no block is given' do
        it 'returns a new camera instance' do
           expect(Camera.open(model, port)).to eq(camera)
        end
      end
    end

    describe '.where' do
      let(:cameras) do
        cameras = []
        cameras << double('camera', model: 'Canon EOS 5D Mark III', port: 'usb:250,004')
        cameras << double('camera', model: 'Nikon DSC D800', port: 'usb:250,005')
        cameras << double('camera', model: 'Nikon DSC D5100', port: 'usb:250,006')
        cameras
      end

      before do
        allow(Camera).to receive(:all).and_return(cameras)
      end

      it 'filters all detected cameras by model' do
        actual = Camera.where(model: /nikon/i)
        expected = [cameras[1], cameras[2]]
        expect(actual).to match_array(expected)
      end

      it 'filters all detected cameras by port' do
        actual = Camera.where(port: 'usb:250,004')
        expected = [cameras[0]]
        expect(actual).to match_array(expected)
      end
    end

    describe '#exit' do
      it 'closes the camera connection' do
        camera = Camera.new(model, port)
        allow(camera).to receive(:_exit)
        expect(camera).to receive(:_exit)
        camera.exit
      end
    end

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

    describe '#wait' do
      let(:camera) { Camera.new(model, port) }
      let(:event) { double('camera_event') }

      before do
        allow(camera).to receive(:wait_for_event).and_return(event)
      end

      it 'waits for a camera event' do
        expect(camera).to receive(:wait_for_event)
        camera.wait
      end

      it 'returns an event symbol' do
        expect(camera.wait).to eq(event)
      end
    end

    describe '#wait_for' do
      let(:camera) { Camera.new(model, port) }
      let(:event) { double('camera_event', type: :capture_complete) }

      before do
        allow(camera).to receive(:wait).and_return(event)
      end

      it 'blocks until a given event is returned from #wait' do
        expect(camera).to receive(:wait)
        camera.wait_for(:capture_complete)
      end

      it 'returns the first event of the given type' do
        expect(camera.wait_for(:capture_complete)).to eq(event)
      end
    end

    describe '#can?' do
      let(:camera) { Camera.new(model, port) }
      let(:operations) { FFI::GPhoto2::CameraOperation[:capture_image] }

      before do
        allow(camera).to receive_message_chain(:abilities, :[]).and_return(operations)
      end

      context 'when the camera does not have the ability perform an operation' do
        it 'return false' do
          expect(camera.can?(:capture_audio)).to be(false)
        end
      end

      context 'when the camera does have the ability to perform an operation' do
        it 'returns true' do
          expect(camera.can?(:capture_image)).to be(true)
        end
      end
    end
  end
end
