shared_examples_for GPhoto2::CameraWidget do
  let(:klass) { described_class }

  describe '#name' do
    it 'returns the name of the widget' do
      name = 'name'
      widget = klass.new(nil)
      allow(widget).to receive(:get_name).and_return(name)
      expect(widget.name).to eq(name)
    end
  end

  describe '#value' do
    it 'returns the value of the widget' do
      value = 'value'
      widget = klass.new(nil)
      allow(widget).to receive(:get_value).and_return(value)
      expect(widget.value).to eq(value)
    end
  end

  describe '#value=' do
    let(:value) { 'value' }
    let(:widget) { klass.new(nil) }

    before do
      expect(widget).to receive(:set_value).with(value)
    end

    it 'sets a new value to the widget' do
      widget.value = value
    end

    it 'returns the passed value' do
      expect(widget.value = value).to eq(value)
    end
  end

  describe '#type' do
    it 'returns the type of the widget' do
      type = :window
      widget = klass.new(nil)
      allow(widget).to receive(:get_type).and_return(type)
      expect(widget.type).to eq(type)
    end
  end

  describe '#label' do
    it 'returns the label of the widget' do
      label = 'Beep'
      widget = klass.new(nil)
      allow(widget).to receive(:get_label).and_return(label)
      expect(widget.label).to eq(label)
    end
  end

  describe '#children' do
    it 'returns an array of child widgets' do
      size = 2

      widget = klass.new(nil)
      allow(widget).to receive(:count_children).and_return(size)
      allow(widget).to receive(:get_child)

      expect(widget).to receive(:get_child).exactly(size).times

      expect(widget.children).to be_kind_of(Array)
    end
  end

  describe '#flatten' do
    %w[a b].each do |name|
      let(name.to_sym) do
        widget = GPhoto2::TextCameraWidget.new(nil)
        allow(widget).to receive(:name).and_return(name)
        allow(widget).to receive(:type).and_return(:text)
        allow(widget).to receive(:children).and_return([])
        widget
      end
    end

    it 'returns a map of name-widget pairs of its descendents' do
      widget = klass.new(nil)
      allow(widget).to receive(:name).and_return('a')
      allow(widget).to receive(:type).and_return(:section)
      allow(widget).to receive(:children).and_return([a, b])

      expect(widget.flatten).to eq({ 'a' => a, 'b' => b })
    end
  end

  describe '#to_s' do
    it "returns the string value of the widget" do
      value = 'value'
      widget = klass.new(nil)
      allow(widget).to receive(:value).and_return(value)
      expect(widget.to_s).to eq(value)
    end
  end
end
