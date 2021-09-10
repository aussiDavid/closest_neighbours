# frozen_string_literal: true

require 'closest_times/times/divide_max_bin'

RSpec.describe ClosestTimes::DivideMaxBin do
  describe '#call' do
    it { expect(described_class.new([[]]).call).to eq [[]] }
    it { expect(described_class.new([[1, 2]]).call).to eq [[1], [2]] }
    it { expect(described_class.new([[1, 2, 3, 4]]).call).to eq [[1, 2], [3, 4]] }
    it { expect(described_class.new([[1, 2, 3]]).call).to eq [[1, 2], [3]] }
    it { expect(described_class.new([[1, 2], [3]]).call).to eq [[1], [2], [3]] }
    it { expect(described_class.new([[1], [2, 3]]).call).to eq [[1], [2], [3]] }
    it { expect(described_class.new([[1], [2, 3], [4, 5]]).call).to eq [[1], [2], [3], [4, 5]] }
    it { expect(described_class.new([[1], []]).call).to eq [[1], []] }
  end
end
