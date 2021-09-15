RSpec.describe ClosestNeighbours do
  it { expect(described_class::VERSION).not_to be nil }
  it { expect(described_class.times(1, [])).not_to be nil }
  it { expect(described_class.ordered(1, [])).not_to be nil }
end
