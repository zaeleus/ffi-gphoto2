shared_examples_for GPhoto2::CameraWidget do |klass|
  describe '#name' do
    it 'returns the name of the widget' do
      name = 'name'
      widget = klass.new(nil)
      widget.stub(:get_name).and_return(name)
      expect(widget.name).to eq(name)
    end
  end

  describe '#value' do
    it 'returns the value of the widget' do
      value = 'value'
      widget = klass.new(nil)
      widget.stub(:get_value).and_return(value)
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
      type = :GP_WIDGET_WINDOW
      widget = klass.new(nil)
      widget.stub(:get_type).and_return(type)
      expect(widget.type).to eq(type)
    end
  end

  describe '#children' do
    it 'returns an array of child widgets' do
      size = 2

      widget = klass.new(nil)
      widget.stub(:count_children).and_return(size)
      widget.stub(:get_child)
      
      expect(widget).to receive(:get_child).exactly(size).times

      expect(widget.children).to be_kind_of(Array) 
    end
  end

  describe '#flatten' do
    %w[a b].each do |name|
      let(name.to_sym) do
        widget = GPhoto2::TextCameraWidget.new(nil)
        widget.stub(:name).and_return(name)
        widget.stub(:type).and_return(:GP_WIDGET_TEXT)
        widget.stub(:children).and_return([])
        widget
      end
    end

    it 'returns a map of name-widget pairs of its descendents' do
      widget = klass.new(nil)
      widget.stub(:name).and_return('a')
      widget.stub(:type).and_return(:GP_WIDGET_SECTION)
      widget.stub(:children).and_return([a, b])

      expect(widget.flatten).to eq({ 'a' => a, 'b' => b })
    end
  end

  describe '#to_s' do
    it "returns the string value of the widget" do
      value = 'value'
      widget = klass.new(nil)
      widget.stub(:value).and_return(value)
      expect(widget.to_s).to eq(value)
    end
  end
end
