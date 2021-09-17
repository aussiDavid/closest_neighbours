# frozen_string_literal: true

module ClosestNeighbours
  # The default order of enumberales
  class DefaultOrder
    def call(data = [])
      data.to_a
    end
  end
end
