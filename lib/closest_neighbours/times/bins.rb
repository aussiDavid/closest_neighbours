# frozen_string_literal: true

module ClosestNeighbours
  # Group an array into bins when seperated by a significant jump
  class Bins
    def initialize(array = [])
      @array = array
    end

    def call
      return [sorted_array] if array.size <= 2

      groups.to_a
    end

    private

    attr_reader :array

    def groups
      previous_diff = sorted_array[1] - sorted_array[0]
      sorted_array.slice_when do |elt_before, elt_after|
        current_diff = elt_after - elt_before
        (current_diff > previous_diff).tap { previous_diff = current_diff }
      end
    end

    def sorted_array
      @sorted_array ||= array.sort
    end
  end
end
