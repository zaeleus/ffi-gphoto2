require 'spec_helper'

module GPhoto2
  describe RadioCameraWidget do
    it_behaves_like CameraWidget, RadioCameraWidget

    describe '#value' do
      it 'has a String return value' do
        widget = RadioCameraWidget.new(nil)
        allow(widget).to receive(:value).and_return('text')
        expect(widget.value).to be_kind_of(String)
      end
    end

    describe '#choices' do
      it 'returns a list of valid radio choices' do
        size = 2

        widget = RadioCameraWidget.new(nil)
        allow(widget).to receive(:count_choices).and_return(size)
        allow(widget).to receive(:get_choice).and_return("choice")

        expect(widget).to receive(:get_choice).exactly(size).times

        choices = widget.choices

        expect(choices.size).to eq(size)
      end
    end
  end
end
