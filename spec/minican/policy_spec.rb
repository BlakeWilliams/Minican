require 'rspec'

describe Minican::Policy do
  it 'sets the instance variable based on class name' do
    obj = Object.new
    policy = FakeModelPolicy.new(obj)

    expect(policy.fake_model).to eq(obj)
  end

  describe 'can?' do
    it 'returns the value of the method passed' do
      expect(true_policy.can?(:read, nil)).to eq(true)
    end

    it 'passes user to the method' do
      user = double(:current_user)
      policy = FakeModelPolicy.new(nil)

      expect(policy).to receive(:read?).with(user)
      policy.can?(:read, user)
    end
  end

  describe '#cannot?' do
    it 'returns the value of the method passed' do
      expect(true_policy.cannot?(:read, nil)).to eq(false)
    end
  end

  describe '#object' do
    it 'returns the passed in object' do
      obj = double(:object)
      policy = FakeModelPolicy.new(obj)

      expect(policy.object).to be(obj)
    end
  end

  def true_policy
    policy = FakeModelPolicy.new(Object.new)

    def policy.read?(user)
      true
    end

    policy
  end
end
