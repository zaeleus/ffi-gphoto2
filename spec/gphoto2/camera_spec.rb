require 'spec_helper'

module GPhoto2
  describe Camera do
    let(:model) { 'Nikon DSC D5100 (PTP mode)' }
    let(:port) { 'usb:250,006' }

    it_behaves_like Camera::Capture
    it_behaves_like Camera::Configuration
    it_behaves_like Camera::Event
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
        let(:camera) { Camera.new(model, port) }

        before do
          allow(Camera).to receive(:all).and_return([camera])
        end

        context 'when a block is given' do
          it 'yeilds the first detected camera' do
            expect(Camera).to receive(:first).and_yield(camera)
            Camera.first { |c| }
          end

          it 'finalizes the camera when the block terminates' do
            expect(camera).to receive(:finalize)
            Camera.first { |c| }
          end
        end

        context 'when no block is given' do
          it 'returns a new Camera using the first entry' do
            expect(Camera.first).to be_kind_of(Camera)
          end
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

    describe '#can?' do
      let(:camera) { Camera.new(model, port) }
      let(:operations) { FFI::GPhoto2::CameraOperation[:capture_image] }

      before do
        allow(camera).to receive_message_chain(:abilities, :[]).and_return(operations)
        allow(camera.abilities).to receive(:operations).and_return(operations)
      end

      context 'when the camera has the ability to perform an operation' do
        it 'returns true' do
          expect(camera.can?(:capture_image)).to be(true)
        end
      end

      context 'when the camera does not have the ability perform an operation' do
        it 'returns false' do
          expect(camera.can?(:capture_audio)).to be(false)
        end
      end

      context 'an invalid operation is given' do
        it 'returns false' do
          expect(camera.can?(:dance)).to be(false)
        end
      end

      context 'the camera has no abilities' do
        it 'returns false' do
          camera = Camera.new(model, port)
          operations = FFI::GPhoto2::CameraOperation[0]
          allow(camera).to receive_message_chain(:abilities, :[]).and_return(operations)
          expect(camera.can?(:capture_image)).to be(false)
        end
      end
    end
  end
end
