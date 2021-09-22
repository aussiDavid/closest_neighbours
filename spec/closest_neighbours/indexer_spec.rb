# frozen_string_literal: true

require 'closest_neighbours/indexer'

RSpec.describe ClosestNeighbours::Indexer do
  describe '#call' do
    it { expect(described_class.new(2, [1, 2]).call).to eq [0, 1, 2] }
    it { expect(described_class.new(2, [1, 2, 3, 4]).call).to eq [0, 2, 4] }
    it { expect(described_class.new(3, [1, 2, 3]).call).to eq [0, 1, 2, 3] }
    it { expect(described_class.new(2, [1, 2, 3]).call).to eq [0, 2, 3] }
    it { expect(described_class.new(2, [1, 2, 10]).call).to eq [0, 2, 3] }
    it { expect(described_class.new(3, [1, 2, 10]).call).to eq [0, 1, 2, 3] }
    it { expect(described_class.new(3, [1, 2, 10, 11, 20]).call).to eq [0, 2, 4, 5] }

    it { expect(described_class.new(4, [1, 2, 3, 4]).call).to eq [0, 1, 2, 3, 4] }
    it { expect(described_class.new(2, [1, 1, 1]).call).to eq [0, 2, 3] }
    it { expect(described_class.new(3, Array.new(6, 1)).call).to eq [0, 2, 4, 6] }
    it { expect(described_class.new(3, Array.new(5, 1)).call).to eq [0, 2, 4, 5] }

    it { expect(described_class.new(2, (1..10_000).to_a + (20_000..30_000).to_a).call).to eq [0, 10_000, 20_001] }
  end
end
