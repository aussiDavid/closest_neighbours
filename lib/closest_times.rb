# frozen_string_literal: true

require 'closest_times/version'

require 'closest_times/times'
require 'closest_times/ordered'

require 'closest_times/errors'

# Takes an array of elements, groups them by their ordered closest neighbors into n groups
module ClosestTimes
  def self.times(groups, data)
    Times.new(groups, data).call
  end

  def self.ordered(groups, data)
    Ordered.new(groups, data).call
  end
end
