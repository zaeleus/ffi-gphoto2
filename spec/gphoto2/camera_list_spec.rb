require 'spec_helper'

module GPhoto2
  describe CameraList do
    before do
      allow_any_instance_of(CameraList).to receive(:new)
    end

    describe '#size' do
      it 'returns the number of camera entries in the list' do
        size = 2

        list = CameraList.new
        allow(list).to receive(:count).and_return(size)

        expect(list.size).to eq(size)
      end
    end

    describe '#to_a' do
      it 'returns an array of camera entries' do
        size = 2

        list = CameraList.new
        allow(list).to receive(:size).and_return(size)

        ary = list.to_a

        expect(ary.size).to eq(size)

        ary.each { |e| expect(e).to be_kind_of(Entry) }
      end
    end
  end
end
