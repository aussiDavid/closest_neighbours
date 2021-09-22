# frozen_string_literal: true

RSpec.describe ClosestNeighbours::Grouper do
  describe '#call' do
    context 'when using the default orderer' do
      let(:instance) { described_class.new(orderer: ClosestNeighbours::DefaultOrder.new) }

      it { expect { instance.call(-1, []) }.to raise_error ClosestNeighbours::InsufficientGroupsError }
      it { expect { instance.call(0, []) }.to raise_error ClosestNeighbours::InsufficientGroupsError }
      it { expect { instance.call('0', []) }.to raise_error ClosestNeighbours::NonIntegerGroupsError }
      it { expect { instance.call(1.0, []) }.to raise_error ClosestNeighbours::NonIntegerGroupsError }
      it { expect { instance.call(1, '[]') }.to raise_error ClosestNeighbours::NonEnumberableArgumentError }
      it { expect { instance.call(1, 1) }.to raise_error ClosestNeighbours::NonEnumberableArgumentError }
      it { expect { instance.call(1, [nil, 1]) }.to raise_error ClosestNeighbours::IncomparableElementError }
      it { expect(instance.call(1, [])).to eq [[]] }
      it { expect(instance.call(2, [])).to eq [[], []] }
      it { expect(instance.call(3, [])).to eq [[], [], []] }
      it { expect(instance.call(4, [])).to eq [[], [], [], []] }
      it { expect(instance.call(1, [1])).to eq [[1]] }
      it { expect(instance.call(2, [1])).to eq [[1], []] }
      it { expect(instance.call(3, [1])).to eq [[1], [], []] }
      it { expect(instance.call(4, [1])).to eq [[1], [], [], []] }
      it { expect(instance.call(1, [1, 2])).to eq [[1, 2]] }
      it { expect(instance.call(2, [1, 2])).to eq [[1], [2]] }
      it { expect(instance.call(4, [1, 2, 3, 4])).to eq [[1], [2], [3], [4]] }
      it { expect(instance.call(2, [1, 2, 10])).to eq [[1, 2], [10]] }
      it { expect(instance.call(2, Set[1, 2, 10])).to eq [[1, 2], [10]] }
      it { expect(instance.call(2, [1, 2, 10].to_enum)).to eq [[1, 2], [10]] }
      it { expect(instance.call(2, (1..10_000).to_a + (20_000..30_000).to_a)).to eq [(1..10_000).to_a, (20_000..30_000).to_a] }

      context 'when using time objects' do
        let(:jan_dates) { [Time.new(2000, 1, 1), Time.new(2000, 1, 13)] }
        let(:may_dates) { [Time.new(2000, 5, 4), Time.new(2000, 5, 7)] }
        let(:aug_dates) { [Time.new(2000, 8, 10), Time.new(2000, 8, 11)] }
        let(:dec_dates) { [Time.new(2000, 12, 28), Time.new(2000, 12, 29)] }
        it do
          expect(instance.call(4,
                               jan_dates + may_dates + aug_dates + dec_dates)).to eq [jan_dates, may_dates, aug_dates, dec_dates]
        end
      end
    end
  end

  context 'when using the sorted orderer' do
    let(:instance) { described_class.new(orderer: ClosestNeighbours::SortedOrder.new) }

    it { expect(instance.call(1, [2, 1])).to eq [[1, 2]] }
    it { expect(instance.call(2, [10, 2, 1])).to eq [[1, 2], [10]] }
  end
end
