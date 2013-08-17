require 'spec_helper'

module GPhoto2
  describe PortInfoList do
    before do
      PortInfoList.any_instance.stub(:new)
      PortInfoList.any_instance.stub(:load)
    end

    describe '#lookup_path' do
      it 'returns the index of the port in the list' do
        port = 'usb:250,006'
        index = 0

        list = PortInfoList.new
        list.stub(:_lookup_path).and_return(index)

        expect(list.lookup_path(port)).to eq(index)
      end
    end

    describe '#at' do
      it 'returns a new PortInfo instance at the specified index' do
        PortInfo.any_instance.stub(:new)

        list = PortInfoList.new
        port_info = list.at(0)

        expect(port_info).to be_kind_of(PortInfo)
      end
    end
  end
end
