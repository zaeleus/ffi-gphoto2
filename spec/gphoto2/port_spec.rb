require 'spec_helper'

module GPhoto2
  describe Port do
    before do
      allow_any_instance_of(Port).to receive(:new)
    end

    describe '#info=' do
      let(:port) { Port.new }

      before do
        allow(port).to receive(:set_info)
      end

      it 'returns the input value' do
        info = double(:port_info)
        expect(port.info = info).to eq(info)
      end
    end
  end
end
