require 'spec_helper'

module GPhoto2
  describe PortInfo do
    let(:port_info_list) { double('port_info_list') }
    let(:index) { 0 }

    before do
      PortInfo.any_instance.stub(:new)
    end

    describe '.find' do
      it 'returns a new PortInfo instance from a port path' do
        PortInfoList.any_instance.stub(:new)
        PortInfoList.any_instance.stub(:load)
        PortInfoList.any_instance.stub(:lookup_path)
        PortInfoList.any_instance.stub(:[]).and_return do
          PortInfo.new(port_info_list, index)
        end

        port_info = PortInfo.find('usb:250,006')
        expect(port_info).to be_kind_of(PortInfo)
      end
    end

    describe '#name' do
      it 'returns the name of the port' do
        name = 'name'
        port_info = PortInfo.new(port_info_list, index)
        port_info.stub(:get_name).and_return(name)
        expect(port_info.name).to eq(name)
      end
    end

    describe '#path' do
      it 'returns the path of the port' do
        path = 'path'
        port_info = PortInfo.new(port_info_list, index)
        port_info.stub(:get_path).and_return(path)
        expect(port_info.path).to eq(path)
      end
    end

    describe '#type' do
      it 'returns the type of the port' do
        type = :GP_PORT_USB
        port_info = PortInfo.new(port_info_list, index)
        port_info.stub(:get_type).and_return(type)
        expect(port_info.type).to eq(type)
      end
    end
  end
end
