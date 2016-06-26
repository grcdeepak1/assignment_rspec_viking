require_relative '../lib/weapons/bow.rb'
describe Bow do
  let(:bow) { Bow.new }

  it "Bow's arrow count is readable" do
    expect(bow.arrows).to be_a(Fixnum)
  end
  it "Bow starts with 10 arrows by default" do
    expect(bow.arrows).to eq(10)
  end
  it "Bow created with a specified number of arrows starts with that number of arrows" do
    bow_7 = Bow.new(7)
    expect(bow_7.arrows).to eq(7)
  end
  it "useing a Bow reduces arrows by 1" do
    bow.use
    expect(bow.arrows).to eq(9)
  end
  it "useing a Bow with 0 arrows throws an error" do
    bow_0 = Bow.new(0)
    expect {bow_0.use}.to raise_error(RuntimeError)
  end
end