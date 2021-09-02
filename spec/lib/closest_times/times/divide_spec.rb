# frozen_string_literal: true

require 'closest_times/times/divide'

RSpec.describe Divide do
  describe '#call' do
    it { expect(described_class.new(0, []).call).to eq [[]] }
    it { expect(described_class.new(1, []).call).to eq [[]] }
    it { expect(described_class.new(1, [1]).call).to eq [[1]] }
    it { expect(described_class.new(1, [1, 2]).call).to eq [[1, 2]] }
    it { expect(described_class.new(2, [1, 2]).call).to eq [[1], [2]] }
    it { expect(described_class.new(3, [1, 2, 3]).call).to eq [[1], [2], [3]] }
    it { expect(described_class.new(4, [1, 2, 3, 4]).call).to eq [[1], [2], [3], [4]] }
    it { expect(described_class.new(2, [1, 2, 3]).call).to eq [[1, 2], [3]] }
    it { expect(described_class.new(2, [1, 2, 3, 4]).call).to eq [[1, 2], [3, 4]] }
    it { expect(described_class.new(3, [1, 2, 3, 4, 5]).call).to eq [[1, 2], [3, 4], [5]] }
  end
end
