require 'spec_helper'

describe Minican::ControllerAdditions do
  describe '#authorize!' do
    it 'raises an error if policy fails' do
      stub_policy_class_with(false)
      controller = define_controller

      expect{
        controller.send(:authorize!, :read, FakeModel.new)
      }.to raise_error(Minican::AccessDenied)
    end

    it 'does not raise error if policy succeeds' do
      stub_policy_class_with(true)
      controller = define_controller

      expect{
        controller.send(:authorize!, :read, FakeModel.new)
      }.not_to raise_error
    end
  end

  describe '#can?' do
    it 'returns the value of the method' do
      stub_policy_class_with(true)
      controller = define_controller

      expect(
        controller.send(:can?, :read, FakeModel.new)
      ).to eq(true)
    end
  end

  describe '#cannot?' do
    it 'returns the opposite value of the method' do
      stub_policy_class_with false
      controller = define_controller

      expect(
        controller.send(:cannot?, :read, FakeModel.new)
      ).to eq(true)
    end
  end

  def stub_policy_class_with(boolean)
    allow_any_instance_of(FakeModelPolicy).to receive(:read?) do
      boolean
    end
  end
  
  def define_controller
    controller = FakeController.new 
  end
end
