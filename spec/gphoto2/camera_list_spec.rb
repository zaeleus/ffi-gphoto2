require 'spec_helper'

module GPhoto2
  describe CameraList do
    before do
      CameraList.any_instance.stub(:new)
    end

    describe '#size' do
      it 'returns the number of camera entries in the list' do
        size = 2

        list = CameraList.new
        list.stub(:count).and_return(size)

        expect(list.size).to eq(size)
      end
    end

    describe '#to_a' do
      it 'returns an array of camera entries' do
        size = 2

        list = CameraList.new
        list.stub(:size).and_return(size)

        ary = list.to_a

        expect(ary.size).to eq(size)

        ary.each { |e| expect(e).to be_kind_of(Entry) }
      end
    end
  end
end
