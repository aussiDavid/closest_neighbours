# frozen_string_literal: true

module ClosestNeighbours
  # Error when an 1 or more element in an enumerable are not comparable with each other
  class IncomparableElementError < StandardError
  end
end
