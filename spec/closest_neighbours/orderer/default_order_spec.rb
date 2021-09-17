# frozen_string_literal: true

RSpec.describe ClosestNeighbours::DefaultOrder do
  describe '#call' do
    it { expect(described_class.new.call([].to_enum)).to eq [] }
    it { expect(described_class.new.call([1].to_enum)).to eq [1] }
    it { expect(described_class.new.call([2, 1].to_enum)).to eq [2, 1] }
    it { expect(described_class.new.call([1, 1].to_enum)).to eq [1, 1] }
  end
end
