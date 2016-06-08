require 'spec_helper'

module GPhoto2
  describe CameraAbilities do
    let(:camera_abilities_list) { double('camera_abilities_list') }
    let(:index) { 0 }

    before do
      allow_any_instance_of(CameraAbilities).to receive(:get_abilities)
    end

    describe '.find' do
      it 'returns a new CameraAbilities instance from a model name' do
        abilities = double('camera_abilities')

        context = double('context')
        allow(context).to receive(:finalize)
        allow(Context).to receive(:new).and_return(context)

        camera_abilities_list = double('camera_abilities_list')
        allow(CameraAbilitiesList).to receive(:new).and_return(camera_abilities_list)
        allow(camera_abilities_list).to receive(:lookup_model).and_return(0)
        allow(camera_abilities_list).to receive(:[]).and_return(abilities)

        expect(CameraAbilities.find('model')).to eq(abilities)
      end
    end

    describe '#[]' do
      it 'returns the value at the given field' do
        key, value = :model, 'name'
        abilities = CameraAbilities.new(camera_abilities_list, index)
        allow(abilities).to receive(:ptr).and_return({ key => value })
        expect(abilities[key]).to eq(value)
      end
    end

    describe '#operations' do
      context 'when no or one operation is supported' do
        it 'returns a bit field of supported operations' do
          abilities = CameraAbilities.new(camera_abilities_list, index)
          allow(abilities).to receive(:[]).and_return(:none)
          expect(abilities.operations).to eq(0)
        end
      end

      context 'when multiple operations are supported' do
        it 'returns a bit field of supported operations' do
          abilities = CameraAbilities.new(camera_abilities_list, index)

          capture_image = FFI::GPhoto2::CameraOperation[:capture_image]
          config = FFI::GPhoto2::CameraOperation[:config]
          operations = capture_image | config

          allow(abilities).to receive(:[]).and_return(operations)
          expect(abilities.operations).to eq(0x11)
        end
      end
    end
  end
end
