# frozen_string_literal: true

module ClosestTimes
  # Splits an evenly array into a specified number of groups
  class Divide
    def initialize(groups = 1, array = [])
      @groups = groups
      @array = array
    end

    def call
      return [array] if groups == 1 || array.empty?

      array.each_slice(slice_size).to_a
    end

    private

    attr_reader :groups, :array

    def slice_size
      (array.size / groups.to_f).round
    end
  end
end
