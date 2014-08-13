module GPhoto2
  shared_examples_for Camera::Configuration do
    describe '#window' do
      let(:camera) { Camera.new(model, port) }
      let(:window) { double('camera_widget') }

      it 'always returns the same CameraWidget instance' do
        allow(camera).to receive(:get_config).and_return(window)
        expect(camera.window).to eq(window)
        expect(camera.window).to eq(window)
      end
    end

    describe '#config' do
      it 'returns a map of configuration widgets' do
        camera = Camera.new(model, port)
        window = double('camera_widget')
        allow(camera).to receive(:window).and_return(window)
        allow(window).to receive(:flatten).and_return({ 'iso' => window })

        expect(camera.config).to eq({ 'iso' => window })
      end
    end

    describe '#[]' do
      let(:window) { double('camera_widget') }

      let(:camera) do
        camera = Camera.new(model, port)
        allow(camera).to receive(:config).and_return({ 'iso' => window })
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
        camera = Camera.new(model, port)
        allow(camera).to receive(:[]).and_return(window)
        camera
      end

      it "sets a widget's value" do
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

    describe '#update' do
      let(:camera) do
        camera = Camera.new(model, port)
        allow(camera).to receive(:[]=)
        allow(camera).to receive(:save)
        camera
      end

      it 'sets one or more camera setting' do
        expect(camera).to receive(:[]=).exactly(2).times
        camera.update('iso' => 400, 'shutterspeed2' => '1/30')
      end

       it 'immediately saves the settings to the camera' do
        expect(camera).to receive(:save)
        camera.update
       end
    end

    describe '#save' do
      let(:camera) do
        camera = Camera.new(model, port)
        allow(camera).to receive_message_chain(:[], :value=)
        allow(camera).to receive(:set_config)
        camera
      end

      context 'when the camera is marked as dirty' do
        it 'returns true' do
          camera['iso'] = 400
          expect(camera.save).to be(true)
        end

        it 'marks the camera as not dirty' do
          camera['iso'] = 400
          camera.save
          expect(camera).not_to be_dirty
        end
      end

      context 'when the camera is not marked as dirty' do
        it 'returns false' do
          expect(camera.save).to be(false)
        end
      end
    end

    describe '#dirty?' do
      context 'when the configuration changed' do
        it 'returns true' do
          camera = Camera.new(model, port)
          allow(camera).to receive_message_chain(:[], :value=)

          camera['iso'] = 400

          expect(camera).to be_dirty
        end
      end

      context 'when the configuration has not changed' do
        it 'returns false' do
          camera = Camera.new(model, port)
          expect(camera).not_to be_dirty
        end
      end
    end
  end
end
