# frozen_string_literal: true

require 'closest_times/version'

# Services
require 'closest_times/times'
require 'closest_times/ordered'

# Errors
require 'closest_times/errors/non_enumberable_argument_error'
require 'closest_times/errors/insufficient_groups_error'
require 'closest_times/errors/non_integer_groups_error'

# Takes an array of elements, groups them by their ordered closest neighbors into n groups
module ClosestTimes
  def self.times(groups, data)
    Times.new(groups, data).call
  end

  def self.ordered(groups, data)
    Ordered.new(groups, data).call
  end
end
