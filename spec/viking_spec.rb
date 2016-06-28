require_relative '../lib/viking.rb'
require_relative '../lib/weapons/bow.rb'
describe Viking do
  let(:oleg) { Viking.new("Oleg") }

  it "Passing a name to a new Viking sets that name attribute" do
    expect(oleg.name).to eq("Oleg")
  end

  it "Passing a health attribute to a new Viking sets that health attribute" do
    sven = Viking.new("Sven", 80)
    expect(sven.health).to eq(80)
  end

  it "health cannot be overwritten after it's been set on initialize" do
    expect { oleg.health = 80 }.to raise_error(NoMethodError)
  end

  it "Viking's weapon starts out nil by default" do
    expect(oleg.weapon).to eq(nil)
  end

  it "Picking up a Weapon sets it as the Viking's weapon" do
    oleg.pick_up_weapon(Bow.new(2))
    expect(oleg.weapon).to be_a(Bow)
  end

  it "Picking up a non-Weapon raises an exception" do
    expect { oleg.pick_up_weapon("Bow") }.to raise_error(RuntimeError)
  end

  it "Picking up a new Weapon replaces the Viking's existing weapon" do
    oleg.pick_up_weapon(Bow.new(2))
    oleg.pick_up_weapon(Axe.new)
    expect(oleg.weapon).to be_a(Axe)
  end

  it "Dropping a Viking's weapon leaves the Viking weaponless" do
    oleg.pick_up_weapon(Bow.new(2))
    oleg.drop_weapon
    expect(oleg.weapon).to eq(nil)
  end

  it "The receive_attack method reduces that Viking's health by the specified amount" do
    oleg.receive_attack(10)
    expect(oleg.health).to eq(90)
  end

  it "The receive_attack method calls the take_damage method" do
    expect(oleg).to receive(:take_damage).and_return(90)
    oleg.receive_attack(10)
  end

  it "attacking another Viking causes the recipient's halth to drop" do
    sven = Viking.new("Sven", 80)
    oleg.attack(sven)
    expect(sven.health).to be < 80
  end

  it "attacking another Viking calls that Viking's take_damage method" do
    sven = Viking.new("Sven", 80)
    expect(sven).to receive(:take_damage)
    oleg.attack(sven)
  end

  it "attacking with no weapon runs damage_with_fists" do
    sven = Viking.new("Sven", 80)
    allow(oleg).to receive(:damage_with_fists).and_return(2.5)
    expect(oleg).to receive(:damage_with_fists)
    oleg.attack(sven)
  end

  it "attacking with no weapon deals Fists multiplier times strength damage" do
    sven = Viking.new("Sven", 80)
    oleg.attack(sven)
    expect(sven.health).to eq(80 - oleg.strength * 0.25)
  end
  it "attacking with a weapon runs damage_with_weapon" do
    sven = Viking.new("Sven", 80)
    oleg.pick_up_weapon(Bow.new(2))
    allow(oleg).to receive(:damage_with_weapon).and_return(20)
    expect(oleg).to receive(:damage_with_weapon)
    oleg.attack(sven)
  end
  it "attacking with a weapon deals damage equal to the Viking's strength times that Weapon's multiplier" do
    sven = Viking.new("Sven", 80)
    oleg.pick_up_weapon(Bow.new(2))
    oleg.attack(sven)
    expect(sven.health).to eq(80 - oleg.strength * 2)
  end
  it "attacking using a Bow without enough arrows uses Fists instead" do
    sven = Viking.new("Sven", 80)
    oleg.pick_up_weapon(Bow.new(2))
    allow(oleg).to receive(:damage_with_fists).and_return(2.5)
    expect(oleg).to receive(:damage_with_fists)
    oleg.attack(sven)
    oleg.attack(sven)
    oleg.attack(sven)
  end
  it "Killing a Viking raises an error" do
    sven = Viking.new("Sven", 80)
    oleg.pick_up_weapon(Bow.new(10))
    expect do
      5.times { oleg.attack(sven) }
    end.to raise_error(RuntimeError)
  end
end
