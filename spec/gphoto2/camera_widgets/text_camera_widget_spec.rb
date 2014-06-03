require 'spec_helper'

module GPhoto2
  describe TextCameraWidget do
    it_behaves_like CameraWidget, TextCameraWidget

    describe '#value' do
      it 'has a String return value' do
        widget = TextCameraWidget.new(nil)
        allow(widget).to receive(:value).and_return('text')
        expect(widget.value).to be_kind_of(String)
      end
    end
  end
end
