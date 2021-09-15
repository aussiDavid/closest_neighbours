# frozen_string_literal: true

RSpec.describe ClosestNeighbours do
  it { expect(described_class::VERSION).not_to be nil }
  it { expect(described_class.group(1, [])).not_to be nil }
end
