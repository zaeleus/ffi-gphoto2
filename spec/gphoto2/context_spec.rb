require 'spec_helper'

module GPhoto2
  describe Context do
    before do
      allow_any_instance_of(Context).to receive(:new)
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
