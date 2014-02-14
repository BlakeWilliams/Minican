require 'spec_helper'

describe Minican::ControllerAdditions do
  describe '#authorize!' do
    it 'raises an error if policy fails' do
      controller = define_controller

      expect{
        controller.send(:authorize!, :read, UnauthorizedModel.new)
      }.to raise_error(Minican::AccessDenied)
    end

    it 'does not raise error if policy succeeds' do
      controller = define_controller

      expect{
        controller.send(:authorize!, :read, AuthorizedModel.new)
      }.not_to raise_error
    end
  end

  describe '#filter_authorized!' do
    it 'filters out unauthorized objects' do
      controller = define_controller
      authorized_model = AuthorizedModel.new
      objects = [authorized_model, UnauthorizedModel.new]

      filtered_objects = controller.send(:filter_authorized!, :read, objects)
      expect(filtered_objects).to eq([authorized_model])
    end

    it 'returns empty when passed nil' do
      controller = define_controller

      filtered_objects = controller.send(:filter_authorized!, :read, nil)
      expect(filtered_objects).to eq([])
    end
  end

  describe '#can?' do
    it 'returns the value of the method' do
      controller = define_controller

      expect(
        controller.send(:can?, :read, AuthorizedModel.new)
      ).to eq(true)
    end
  end

  describe '#cannot?' do
    it 'returns the opposite value of the method' do
      controller = define_controller

      expect(
        controller.send(:cannot?, :read, UnauthorizedModel.new)
      ).to eq(true)
    end
  end

  def define_controller
    controller = FakeController.new
  end
end
