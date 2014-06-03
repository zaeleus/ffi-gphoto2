require 'spec_helper'

module GPhoto2
  describe RangeCameraWidget do
    it_behaves_like CameraWidget, RangeCameraWidget

    describe '#value' do
      it 'has a Float return value' do
        widget = RangeCameraWidget.new(nil)
        allow(widget).to receive(:value).and_return(0.0)
        expect(widget.value).to be_kind_of(Float)
      end
    end

    describe '#range' do
      it 'returns a list of valid range options' do
        min, max, inc = 0, 2, 0.5
        range = (min..max).step(inc).to_a

        widget = RangeCameraWidget.new(nil)
        allow(widget).to receive(:get_range).and_return([min, max, inc])

        expect(widget.range).to eq(range)
      end
    end
  end
end
