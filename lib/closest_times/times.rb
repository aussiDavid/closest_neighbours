# frozen_string_literal: true

require 'closest_times/times/bins'
require 'closest_times/times/divide_max_bin'

# Match array of times up into groups that are the closest to each other
class Times
  def initialize(groups = 1, array = [])
    @groups = groups
    @array = array
  end

  def call
    raise ClosestTimes::NonIntegerGroupsError unless groups.is_a? Integer
    raise ClosestTimes::NonEnumberableArgumentError unless array.is_a? Enumerable
    raise ClosestTimes::InsuffcientGroupsError if groups < 1

    return fillers if array.empty?

    divide_bins + fillers
  end

  private

  attr_reader :groups, :array

  def fillers
    Array.new(number_of_fillers, [])
  end

  def number_of_fillers
    [0, groups - array.length].max
  end

  def divide_bins
    (groups - bins.size).times.reduce(bins) { |acc, _cur| DivideMaxBin.new(acc).call }
  end

  def bins
    @bins ||= Bins.new(array).call
  end
end
