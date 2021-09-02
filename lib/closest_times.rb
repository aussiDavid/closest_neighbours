require 'closest_times/version'
require 'closest_times/times'
require 'closest_times/ordered'

module ClosestTimes
  class InsuffcientGroupsError < StandardError; end
  class NonIntegerGroupsError < StandardError; end
  class NonEnumberableArgumentError < StandardError; end
end
