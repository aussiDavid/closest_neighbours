# frozen_string_literal: true

RSpec.describe ClosestTimes::Ordered do
  describe '#call' do
    it { expect { described_class.new(-1, []).call }.to raise_error ClosestTimes::InsufficientGroupsError }
    it { expect { described_class.new(0, []).call }.to raise_error ClosestTimes::InsufficientGroupsError }
    it { expect { described_class.new('0', []).call }.to raise_error ClosestTimes::NonIntegerGroupsError }
    it { expect { described_class.new(1.0, []).call }.to raise_error ClosestTimes::NonIntegerGroupsError }
    it { expect { described_class.new(1, '[]').call }.to raise_error ClosestTimes::NonEnumberableArgumentError }
    it { expect { described_class.new(1, 1).call }.to raise_error ClosestTimes::NonEnumberableArgumentError }
    it { expect(described_class.new(1, []).call).to eq [[]] }
    it { expect(described_class.new(2, []).call).to eq [[], []] }
    it { expect(described_class.new(3, []).call).to eq [[], [], []] }
    it { expect(described_class.new(4, []).call).to eq [[], [], [], []] }
    it { expect(described_class.new(1, [1]).call).to eq [[1]] }
    it { expect(described_class.new(2, [1]).call).to eq [[1], []] }
    it { expect(described_class.new(3, [1]).call).to eq [[1], [], []] }
    it { expect(described_class.new(4, [1]).call).to eq [[1], [], [], []] }
    it { expect(described_class.new(1, [1, 2]).call).to eq [[1, 2]] }
    it { expect(described_class.new(1, [2, 1]).call).to eq [[1, 2]] }
    it { expect(described_class.new(2, [1, 2]).call).to eq [[1], [2]] }
    it { expect(described_class.new(2, [1, 2, 10]).call).to eq [[1, 2], [10]] }
    it { expect(described_class.new(4, [1, 2, 3, 4]).call).to eq [[1], [2], [3], [4]] }
    it { expect(described_class.new(2, [1, 2, 3]).call).to eq [[1, 2], [3]] }
    it {
      pending('Not implemented. Contiguous numbers with the same differences are not supported')
      expect(described_class.new(2, [1, 2, 3, 4]).call).to eq [[1, 2], [3, 4]]
    }
    it {
      pending('Not implemented. Contiguous numbers with the same differences are not supported')
      expect(described_class.new(2, (1..5).to_a).call).to eq [(1..3).to_a, [4, 5]]
    }
    it {
      pending('Not implemented. Contiguous numbers with the same differences are not supported')
      expect(described_class.new(2, (1..5).to_a.reverse).call).to eq [(1..3).to_a, [4, 5]]
    }
    it { expect(described_class.new(2, [1, 1, 1]).call).to eq [[1, 1], [1]] }
    it { expect(described_class.new(2, [2, 1, 2, 1]).call).to eq [[1, 1], [2, 2]] }
    it { expect(described_class.new(2, [1, 2, 3, 10]).call).to eq [[1, 2, 3], [10]] }
    it { expect(described_class.new(3, [1, 2, 3, 10]).call).to eq [[1, 2], [3], [10]] }
    it { expect(described_class.new(3, [1, 2, 20, 25, 50]).call).to eq [[1, 2], [20, 25], [50]] }
    it { expect(described_class.new(3, [1, 2, 5, 20, 22]).call).to eq [[1, 2], [5], [20, 22]] }
    it { expect(described_class.new(3, Set[1, 2, 5, 20, 22]).call).to eq [[1, 2], [5], [20, 22]] }
    it { expect(described_class.new(3, [1, 2, 5, 20, 22].to_enum).call).to eq [[1, 2], [5], [20, 22]] }

    context 'when using time objects' do
      let(:jan_dates) { [Time.new(2000, 1, 1), Time.new(2000, 1, 13)] }
      let(:may_dates) { [Time.new(2000, 5, 4), Time.new(2000, 5, 7)] }
      let(:aug_dates) { [Time.new(2000, 8, 10), Time.new(2000, 8, 11)] }
      let(:dec_dates) { [Time.new(2000, 12, 28), Time.new(2000, 12, 29)] }
      it {
        expect(described_class.new(4,
                                   jan_dates + may_dates + aug_dates + dec_dates).call).to eq [jan_dates, may_dates,
                                                                                               aug_dates, dec_dates]
      }
    end
  end
end
