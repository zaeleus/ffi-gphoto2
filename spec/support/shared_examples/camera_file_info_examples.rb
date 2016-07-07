shared_examples_for GPhoto2::CameraFileInfo do
  let(:camera_file_info) do
    OpenStruct.new(
      fields: 0xff,
      status: :not_downloaded,
      size: 7355608,
      type: 'image/jpeg'
    )
  end

  let(:info) { described_class.new(camera_file_info) }

  describe '#fields' do
    it 'returns a bit field of set fields' do
      expect(info.fields).to eq(0xff)
    end
  end

  describe '#has_field?' do
    it 'returns whether a field is set' do
      expect(info.has_field?(:size)).to be(true)
    end
  end

  describe '#status' do
    it 'returns the file status' do
      expect(info.status).to eq(:not_downloaded)
    end
  end

  describe '#size' do
    it 'returns the filesize' do
      expect(info.size).to eq(7355608)
    end
  end

  describe '#type' do
    it 'returns the file type' do
      expect(info.type).to eq('image/jpeg')
    end
  end
end
