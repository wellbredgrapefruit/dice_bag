require 'dice_bag'

RSpec.describe DiceBag::Dice, 'default - 6 sides' do
  subject { DiceBag::Dice.new }
  it "is a dice" do
    expect(subject).to be_a DiceBag::Dice
  end
  it 'has six sides' do
    expect(subject.sides).to eq 6
  end
  context "#roll" do
    it 'returns a random value between 1 and 6' do
      result = subject.roll
      expect(result).to be >= 1
      expect(result).to be <= 6
    end
    it 'returns the same value if a seed is provided' do
      seed = 1234
      second_dice = DiceBag::Dice.new
      expect(subject.roll(seed)).to eq second_dice.roll(seed)
    end
  end
  context "#rolls" do
    it 'returns an array of values between 1 and 6' do
      results = subject.rolls(3)
      expect(results.size).to be 3
    end
    it 'raises an ArgumentError on a negative value' do
      expect { subject.rolls(-3) }.to raise_error(DiceBag::InvalidSidesError, 'number of times to roll must be a positive integer')
    end
  end
end

RSpec.describe DiceBag::Dice, 'invalid dice' do
  context 'Invalid Sides' do
    it 'raises an ArgumentError on a negative value' do
      expect { DiceBag::Dice.new(-3) }.to raise_error(DiceBag::InvalidSidesError, 'Dice must have a positive integer number of sides')
    end
  end
  context 'Too Large' do
    it 'raises an OutOfBoundsError on a value greater than 1000' do
      expect { DiceBag::Dice.new(1001) }.to raise_error(DiceBag::TooLargeError, 'Dice has too many sides')
    end
  end
end
