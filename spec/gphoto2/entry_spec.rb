require 'spec_helper'

module GPhoto2
  describe Entry do
    let(:entry) { Entry.new(double('camera_list'), 0) }

    let(:name) { 'model' }
    let(:value) { 'usb:250,006' }

    before do
      entry.stub(:get_name).and_return(name)
      entry.stub(:get_value).and_return(value)
    end

    describe '#name' do
      it 'returns the name of the entry' do
        expect(entry.name).to eq(name)
      end
    end

    describe '#value' do
      it 'returns the value of the entry' do
        expect(entry.value).to eq(value)
      end
    end
  end
end
