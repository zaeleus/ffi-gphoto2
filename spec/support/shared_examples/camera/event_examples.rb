module GPhoto2
  shared_examples_for Camera::Event do
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
  end
end
