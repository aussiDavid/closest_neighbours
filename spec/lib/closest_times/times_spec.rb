# frozen_string_literal: true

RSpec.describe ClosestTimes::Times do
  describe '#call' do
    it { expect(described_class.new(1, []).call).to eq [[]] }
    it { expect(described_class.new(2, []).call).to eq [[], []] }
    it { expect(described_class.new(3, []).call).to eq [[], [], []] }
    it { expect(described_class.new(4, []).call).to eq [[], [], [], []] }
    it { expect(described_class.new(1, [Time.new(2000, 1, 1)]).call).to eq [[Time.new(2000, 1, 1)]] }
    it { expect(described_class.new(2, [Time.new(2000, 1, 1)]).call).to eq [[Time.new(2000, 1, 1)], []] }
    it { expect(described_class.new(3, [Time.new(2000, 1, 1)]).call).to eq [[Time.new(2000, 1, 1)], [], []] }
    it { expect(described_class.new(4, [Time.new(2000, 1, 1)]).call).to eq [[Time.new(2000, 1, 1)], [], [], []] }
    it { expect(described_class.new(1, [Time.new(2000, 1, 2), Time.new(2000, 1, 1)]).call).to eq [[Time.new(2000, 1, 1), Time.new(2000, 1, 2)]] }
    it { expect(described_class.new(2, [Time.new(2000, 1, 2), Time.new(2000, 1, 1)]).call).to eq [[Time.new(2000, 1, 1)], [Time.new(2000, 1, 2)]] }
    it { expect(described_class.new(3, [Time.new(2000, 1, 2), Time.new(2000, 1, 1), Time.new(2000, 1, 3)]).call).to eq [[Time.new(2000, 1, 1)], [Time.new(2000, 1, 2)], [Time.new(2000, 1, 3)]] }
    it { expect(described_class.new(4, [Time.new(2000, 1, 2), Time.new(2000, 1, 1), Time.new(2000, 1, 3)]).call).to eq [[Time.new(2000, 1, 1)], [Time.new(2000, 1, 2)], [Time.new(2000, 1, 3)], []] }
    it { expect(described_class.new(4, [Time.new(2000, 1, 2), Time.new(2000, 1, 1), Time.new(2000, 1, 3), Time.new(2000, 1, 4)]).call).to eq [[Time.new(2000, 1, 1)], [Time.new(2000, 1, 2)], [Time.new(2000, 1, 3)], [Time.new(2000, 1, 4)]] }
    it { expect(described_class.new(4, (1..4).to_a).call).to eq [[1], [2], [3], [4]] }
    # it { expect(described_class.new(2, (1..3).to_a).call).to eq [[1, 2], [3]] }
    # it { expect(described_class.new(2, (1..4).to_a).call).to eq [[1, 2], [3, 4]] }
    # it { expect(described_class.new(2, (1..5).to_a).call).to eq [(1..3).to_a, [4, 5]] }
    # it { expect(described_class.new(2, (1..5).to_a.reverse).call).to eq [(1..3).to_a, [4, 5]] }
    # it { expect(described_class.new(2, [1, 1, 1]).call).to eq [[1, 1], [1]] }
    it { expect(described_class.new(2, [2, 1, 2, 1]).call).to eq [[1, 1], [2, 2]] }
    it { expect(described_class.new(2, [1, 2, 3, 10]).call).to eq [[1, 2, 3], [10]] }
    # it { expect(described_class.new(3, [1, 2, 3, 10]).call).to eq [[1, 2, 3], [10], []] }
    it { expect { described_class.new(0, []).call }.to raise_error StandardError }
  end
end
