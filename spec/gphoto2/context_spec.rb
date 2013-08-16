require 'spec_helper'

module GPhoto2
  describe Context do
    before do
      Context.any_instance.stub(:new)
    end

    describe '#finalize' do
      it 'decrements the reference counter' do
        context = Context.new
        expect(context).to receive(:unref)
        context.finalize
      end
    end
  end
end
