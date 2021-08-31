# frozen_string_literal: true

require 'closest_times/bins'

module ClosestTimes
  # Match array of times up into groups that are the closest to each other
  class Times
    def initialize(groups = 1, times = [])
      @groups = groups
      @times = times
    end

    def call
      raise StandardError if groups < 1

      return [sorted_times] if groups == 1
      return identity + fillers if groups >= times.length
      return bins if groups == bins.size
      return bins.flatten(1).each_slice(slice_size).to_a if groups < bins.size

      bins + fillers
    end

    private

    attr_reader :groups, :times

    def fillers
      Array.new(number_of_fillers, [])
    end

    def number_of_fillers
      [0, groups - times.length].max
    end

    def sorted_times
      @sorted_times ||= times.sort
    end

    def slice_size
      (times.length / groups.to_f).ceil
    end

    def identity
      sorted_times.map { |item| [item] }
    end

    def bins
      @bins ||= ClosestTimes::Bins.new(times).call
    end
  end
end
