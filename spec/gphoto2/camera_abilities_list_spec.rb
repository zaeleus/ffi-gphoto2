require 'spec_helper'

module GPhoto2
  describe CameraAbilitiesList do
    let(:context) { double('context') }

    before do
      allow_any_instance_of(CameraAbilitiesList).to receive(:new)
      allow_any_instance_of(CameraAbilitiesList).to receive(:load)
    end

    describe '#detect' do
      it 'returns a list cameras' do
        camera_list = double('camera_list')

        abilities_list = CameraAbilitiesList.new(context)
        allow(abilities_list).to receive(:_detect).and_return(camera_list)

        expect(abilities_list.detect).to eq(camera_list)
      end
    end

    describe '#lookup_model' do
      it 'returns the index of the abilities in the list' do
        index = 0

        list = CameraAbilitiesList.new(context)
        allow(list).to receive(:_lookup_model).and_return(index)

        expect(list.lookup_model('model')).to eq(index)
      end
    end

    describe '#at' do
      it 'returns a new CameraAbilities instance at the specified index' do
        abilities = double('camera_abilities')

        allow(CameraAbilities).to receive(:new).and_return(abilities)
        list = CameraAbilitiesList.new(context)

        expect(list.at(0)).to eq(abilities)
      end
    end
  end
end
