require 'spec_helper'

describe GPhoto2 do
  describe '.check!' do
    context 'the return code is not GP_OK' do
      it 'raises GPhoto2::Error with a message and error code' do
        message = 'Unspecified error (-1)'
        expect { GPhoto2.check!(-1) }.to raise_error(GPhoto2::Error, message)
      end
    end
  end
end
