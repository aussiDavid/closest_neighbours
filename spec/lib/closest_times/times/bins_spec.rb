# frozen_string_literal: true

require 'closest_times/times/bins'

RSpec.describe Bins do
  describe '#call' do
    it { expect(described_class.new([]).call).to eq [[]] }
    it { expect(described_class.new([1]).call).to eq [[1]] }
    it { expect(described_class.new([1, 2]).call).to eq [[1, 2]] }
    it { expect(described_class.new([1, 2, 3]).call).to eq [[1, 2, 3]] }
    it { expect(described_class.new([1, 2, 10]).call).to eq [[1, 2], [10]] }
    it { expect(described_class.new([1, 2, 10, 11]).call).to eq [[1, 2], [10, 11]] }
    it { expect(described_class.new([1, 2, 10, 11, 11]).call).to eq [[1, 2], [10, 11, 11]] }
    it { expect(described_class.new([10, 11, 2, 1, 11]).call).to eq [[1, 2], [10, 11, 11]] }
    it { expect(described_class.new([1, 2, 10, 11, 20, 25]).call).to eq [[1, 2], [10, 11], [20, 25]] }
    it { expect(described_class.new([1, 2, 10, 100]).call).to eq [[1, 2], [10], [100]] }
    # it { expect(described_class.new([1, 9, 10]).call).to eq [[1], [9, 10]] }
    # it { expect(described_class.new([1, 20, 25, 30]).call).to eq [[1], [20, 25, 30]] }
  end
end
