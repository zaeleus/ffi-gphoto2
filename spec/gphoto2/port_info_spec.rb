require 'spec_helper'

module GPhoto2
  describe PortInfo do
    let(:port_info_list) { double('port_info_list') }
    let(:index) { 0 }

    before do
      allow_any_instance_of(PortInfo).to receive(:new)
    end

    describe '.find' do
      it 'returns a new PortInfo instance from a port path' do
        allow_any_instance_of(PortInfoList).to receive(:new)
        allow_any_instance_of(PortInfoList).to receive(:load)
        allow_any_instance_of(PortInfoList).to receive(:lookup_path)
        info = PortInfo.new(port_info_list, index)
        allow_any_instance_of(PortInfoList).to receive(:[]).and_return(info)

        port_info = PortInfo.find('usb:250,006')
        expect(port_info).to be_kind_of(PortInfo)
      end
    end

    describe '#name' do
      it 'returns the name of the port' do
        name = 'name'
        port_info = PortInfo.new(port_info_list, index)
        allow(port_info).to receive(:get_name).and_return(name)
        expect(port_info.name).to eq(name)
      end
    end

    describe '#path' do
      it 'returns the path of the port' do
        path = 'path'
        port_info = PortInfo.new(port_info_list, index)
        allow(port_info).to receive(:get_path).and_return(path)
        expect(port_info.path).to eq(path)
      end
    end

    describe '#type' do
      it 'returns the type of the port' do
        type = :usb
        port_info = PortInfo.new(port_info_list, index)
        allow(port_info).to receive(:get_type).and_return(type)
        expect(port_info.type).to eq(type)
      end
    end
  end
end
