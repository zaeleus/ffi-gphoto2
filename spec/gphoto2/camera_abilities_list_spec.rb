require 'spec_helper'

module GPhoto2
  describe CameraAbilitiesList do
    let(:context) { double('context') }

    before do
      CameraAbilitiesList.any_instance.stub(:new)
      CameraAbilitiesList.any_instance.stub(:load)
    end

    describe '#detect' do
      it 'returns a list cameras' do
        camera_list = double('camera_list')
        abilities_list = CameraAbilitiesList.new(context)
        abilities_list.stub(:_detect).and_return(camera_list)

        expect(abilities_list.detect).to eq(camera_list)
      end
    end
  end
end
