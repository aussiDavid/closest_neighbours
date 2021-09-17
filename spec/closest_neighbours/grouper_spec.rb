# frozen_string_literal: true

RSpec.describe ClosestNeighbours::Grouper do
  describe '#call' do
    context 'when using the default orderer' do
      let(:orderer) { ClosestNeighbours::DefaultOrder.new }

      it { expect { described_class.new(-1, [], orderer: orderer).call }.to raise_error ClosestNeighbours::InsufficientGroupsError }
      it { expect { described_class.new(0, [], orderer: orderer).call }.to raise_error ClosestNeighbours::InsufficientGroupsError }
      it { expect { described_class.new('0', [], orderer: orderer).call }.to raise_error ClosestNeighbours::NonIntegerGroupsError }
      it { expect { described_class.new(1.0, [], orderer: orderer).call }.to raise_error ClosestNeighbours::NonIntegerGroupsError }
      it { expect { described_class.new(1, '[]', orderer: orderer).call }.to raise_error ClosestNeighbours::NonEnumberableArgumentError }
      it { expect { described_class.new(1, 1, orderer: orderer).call }.to raise_error ClosestNeighbours::NonEnumberableArgumentError }
      it { expect { described_class.new(1, [nil, 1], orderer: orderer).call }.to raise_error ClosestNeighbours::IncomparableElementError }
      it { expect(described_class.new(1, [], orderer: orderer).call).to eq [[]] }
      it { expect(described_class.new(2, [], orderer: orderer).call).to eq [[], []] }
      it { expect(described_class.new(3, [], orderer: orderer).call).to eq [[], [], []] }
      it { expect(described_class.new(4, [], orderer: orderer).call).to eq [[], [], [], []] }
      it { expect(described_class.new(1, [1], orderer: orderer).call).to eq [[1]] }
      it { expect(described_class.new(2, [1], orderer: orderer).call).to eq [[1], []] }
      it { expect(described_class.new(3, [1], orderer: orderer).call).to eq [[1], [], []] }
      it { expect(described_class.new(4, [1], orderer: orderer).call).to eq [[1], [], [], []] }
      it { expect(described_class.new(1, [1, 2], orderer: orderer).call).to eq [[1, 2]] }
      it { expect(described_class.new(2, [1, 2], orderer: orderer).call).to eq [[1], [2]] }
      it { expect(described_class.new(2, [1, 2, 10], orderer: orderer).call).to eq [[1, 2], [10]] }
      it { expect(described_class.new(4, [1, 2, 3, 4], orderer: orderer).call).to eq [[1], [2], [3], [4]] }
      it { expect(described_class.new(2, [1, 2, 3], orderer: orderer).call).to eq [[1, 2], [3]] }
      it {
        pending('Not implemented. Contiguous numbers with the same differences are not supported')
        expect(described_class.new(2, [1, 2, 3, 4], orderer: orderer).call).to eq [[1, 2], [3, 4]]
      }
      it {
        pending('Not implemented. Contiguous numbers with the same differences are not supported')
        expect(described_class.new(2, (1..5).to_a, orderer: orderer).call).to eq [(1..3).to_a, [4, 5]]
      }
      it {
        pending('Not implemented. Contiguous numbers with the same differences are not supported')
        expect(described_class.new(2, (1..5).to_a.reverse, orderer: orderer).call).to eq [(1..3).to_a, [4, 5]]
      }
      it { expect(described_class.new(2, [1, 1, 1], orderer: orderer).call).to eq [[1, 1], [1]] }
      it { expect(described_class.new(2, [1, 2, 3, 10], orderer: orderer).call).to eq [[1, 2, 3], [10]] }
      it { expect(described_class.new(3, [1, 2, 3, 10], orderer: orderer).call).to eq [[1, 2], [3], [10]] }
      it { expect(described_class.new(3, [1, 2, 20, 25, 50], orderer: orderer).call).to eq [[1, 2], [20, 25], [50]] }
      it { expect(described_class.new(3, [1, 2, 5, 20, 22], orderer: orderer).call).to eq [[1, 2], [5], [20, 22]] }
      it { expect(described_class.new(3, Set[1, 2, 5, 20, 22], orderer: orderer).call).to eq [[1, 2], [5], [20, 22]] }
      it { expect(described_class.new(3, [1, 2, 5, 20, 22].to_enum, orderer: orderer).call).to eq [[1, 2], [5], [20, 22]] }
      it { expect(described_class.new(3, [1, 2, 5, 20, 22].to_enum, orderer: orderer).call).to eq [[1, 2], [5], [20, 22]] }
      it { expect(described_class.new(2, (1..10_000).to_a + (20_000..30_000).to_a, orderer: orderer).call).to eq [(1..10_000).to_a, (20_000..30_000).to_a] }

      context 'when using time objects' do
        let(:jan_dates) { [Time.new(2000, 1, 1), Time.new(2000, 1, 13)] }
        let(:may_dates) { [Time.new(2000, 5, 4), Time.new(2000, 5, 7)] }
        let(:aug_dates) { [Time.new(2000, 8, 10), Time.new(2000, 8, 11)] }
        let(:dec_dates) { [Time.new(2000, 12, 28), Time.new(2000, 12, 29)] }
        it {
          expect(described_class.new(4,
                                     jan_dates + may_dates + aug_dates + dec_dates, orderer: orderer).call).to eq [jan_dates, may_dates,
                                                                                                                   aug_dates, dec_dates]
        }
      end
    end
  end

  context 'when using the sorted orderer' do
    let(:orderer) { ClosestNeighbours::SortedOrder.new }

    it { expect(described_class.new(1, [2, 1], orderer: orderer).call).to eq [[1, 2]] }
    it { expect(described_class.new(2, [2, 1, 2, 1], orderer: orderer).call).to eq [[1, 1], [2, 2]] }
  end
end
