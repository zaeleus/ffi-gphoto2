require 'spec_helper'

module GPhoto2
  describe ToggleCameraWidget do
    it_behaves_like CameraWidget, ToggleCameraWidget

    describe '#value' do
      it 'can have a TrueClass return value' do
        widget = ToggleCameraWidget.new(nil)
        widget.stub(:value).and_return(true)
        expect(widget.value).to be_kind_of(TrueClass)
      end

      it 'can have a FalseClass return value' do
        widget = ToggleCameraWidget.new(nil)
        widget.stub(:value).and_return(false)
        expect(widget.value).to be_kind_of(FalseClass)
      end
    end
  end
end
