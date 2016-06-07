require 'spec_helper'

describe GPhoto2 do
  describe '.check!' do
    context 'the return code is not GP_OK' do
      it 'raises GPhoto2::Error with a message and error code' do
        code = -1
        message = "Unspecified error (#{code})"
        expect { GPhoto2.check!(code) }.to raise_error(GPhoto2::Error, message) {|e| expect(e.code).to eq code }
      end
    end
  end
end
