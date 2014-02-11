require 'spec_helper'

describe Minican::Helpers do
  before do
    @object = Object.new
    @object.send(:extend, Minican::Helpers)
  end

  describe '#policy_class' do
    context 'when an instance' do
      it 'returns the policy class' do
        expect(
          @object.send(:policy_class, FakeModel.new)
        ).to eq(FakeModelPolicy)
      end
    end

    context 'when a class' do
      it 'returns the policy for class' do
        expect(
          @object.send(:policy_class, FakeModel)
        ).to eq(FakeModelPolicy)
      end
    end
  end

  describe '#policy_for' do
    it 'returns an instance of policy class' do
      expect(
        @object.send(:policy_for, FakeModel.new)
      ).to be_instance_of(FakeModelPolicy)
    end
  end
end
