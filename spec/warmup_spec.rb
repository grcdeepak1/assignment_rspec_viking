require_relative '../lib/warmup.rb'
describe Warmup do
  let(:warmup) { Warmup.new }

  describe '#gets_shout' do
    it 'should return upcased string' do
      allow(warmup).to receive(:gets).and_return("hello")
      expect(warmup.gets_shout).to eq("HELLO")
    end
    it 'should call puts' do
      allow(warmup).to receive(:gets).and_return("hello")
      expect(warmup).to receive(:puts).with("HELLO").and_return(nil)
      warmup.gets_shout
    end
  end

  describe '#triple_size' do
    it 'should return 3 times the size' do
      my_arr = instance_double("Array", :size => 4)
      expect(warmup.triple_size(my_arr)).to eq(12)
    end
  end

  describe '#calls_some_methods' do
    it 'string you pass in receives the #upcase!' do
      my_str = instance_double("String", :upcase! => "LOUD_STR")
      expect(my_str).to receive(:upcase!)
      warmup.calls_some_methods(my_str)
    end

    it 'string you pass in receives the #reverse!' do
      loud_str = "LOUD_STR"
      my_str = instance_double("String", :upcase! => loud_str)
      expect(loud_str).to receive(:reverse!)
      warmup.calls_some_methods(my_str)
    end

    it 'returns completely different object than the one passed in' do
      my_str = "Hello"
      expect(warmup.calls_some_methods(my_str).object_id).not_to eq(my_str.object_id)
    end
  end
end