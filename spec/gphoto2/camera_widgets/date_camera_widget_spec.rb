require 'spec_helper'

module GPhoto2
  describe DateCameraWidget do
    it_behaves_like CameraWidget, DateCameraWidget

    describe '#value' do
      it 'has a Time return value' do
        widget = DateCameraWidget.new(nil)
        allow(widget).to receive(:value).and_return(Time.now)
        expect(widget.value).to be_kind_of(Time)
      end
    end
  end
end
