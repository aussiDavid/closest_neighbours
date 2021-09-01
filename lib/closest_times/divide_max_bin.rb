# frozen_string_literal: true

require 'closest_times/divide'

module ClosestTimes
  # Splits the largest bin into 2, increasing the number of bins by 1
  class DivideMaxBin
    def initialize(array = [[]])
      @array = array
    end

    def call
      before + middle + after
    end

    private

    attr_reader :array

    def before
      index.zero? ? [] : array[0..index - 1]
    end

    def middle
      ClosestTimes::Divide.new(2, array[index]).call
    end

    def after
      array[index + 1..array.size]
    end

    def index
      array.find_index(max)
    end

    def max
      array.max_by(&:size)
    end
  end
end
