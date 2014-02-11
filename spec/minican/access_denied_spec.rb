require 'spec_helper'

describe Minican::AccessDenied do
  describe '#policy' do
    it 'returns the passed in object' do
      policy = Object.new
      Minican::AccessDenied.new(policy)

      expect(policy).to be(policy)
    end
  end

  describe '#to_s' do
    it 'returns a human readable error' do
      error = Minican::AccessDenied.new(nil)
      expect(error.to_s).to eq("You are not authorized to access this page")
    end
  end
end
