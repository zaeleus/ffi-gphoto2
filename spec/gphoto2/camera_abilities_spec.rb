require 'spec_helper'

module GPhoto2
  describe CameraAbilities do
    let(:camera_abilities_list) { double('camera_abilities_list') }
    let(:index) { 0 }

    before do
      CameraAbilities.any_instance.stub(:get_abilities)
    end

    describe '.find' do
      it 'returns a new CameraAbilities instance from a model name' do
        abilities = double('camera_abilities')

        context = double('context')
        context.stub(:finalize)
        Context.stub(:new).and_return(context)

        camera_abilities_list = double('camera_abilities_list')
        CameraAbilitiesList.stub(:new).and_return(camera_abilities_list)
        camera_abilities_list.stub(:lookup_model).and_return(0)
        camera_abilities_list.stub(:[]).and_return(abilities)

        expect(CameraAbilities.find('model')).to eq(abilities)
      end
    end

    describe '#[]' do
      it 'returns the value at the given field' do
        key, value = :model, 'name'
        abilities = CameraAbilities.new(camera_abilities_list, index)
        abilities.stub(:ptr).and_return({ key => value })
        expect(abilities[key]).to eq(value)
      end
    end
  end
end
