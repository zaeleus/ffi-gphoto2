require 'spec_helper'

module GPhoto2
  describe PortInfoList do
    before do
      allow_any_instance_of(PortInfoList).to receive(:new)
      allow_any_instance_of(PortInfoList).to receive(:load)
    end

    describe '#lookup_path' do
      it 'returns the index of the port in the list' do
        port = 'usb:250,006'
        index = 0

        list = PortInfoList.new
        allow(list).to receive(:_lookup_path).and_return(index)

        expect(list.lookup_path(port)).to eq(index)
      end
    end

    describe '#at' do
      it 'returns a new PortInfo instance at the specified index' do
        allow_any_instance_of(PortInfo).to receive(:new)

        list = PortInfoList.new
        port_info = list.at(0)

        expect(port_info).to be_kind_of(PortInfo)
      end
    end
  end
end
