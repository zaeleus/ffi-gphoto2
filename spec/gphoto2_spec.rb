require 'spec_helper'

describe GPhoto2 do
  describe '.check!' do
    context 'the return code is not GP_OK' do
      it 'raises GPhoto2::Error with a message and error code' do
        code = -1
        message = "Unspecified error (#{code})"

        expect { GPhoto2.check!(code) }.to raise_error do |e|
          expect(e).to be_kind_of(GPhoto2::Error)
          expect(e.message).to eq(message)
          expect(e.code).to eq(code)
        end
      end
    end
  end
end
