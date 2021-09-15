# frozen_string_literal: true

require 'closest_neighbours/version'

# Services
require 'closest_neighbours/times'
require 'closest_neighbours/ordered'

# Errors
require 'closest_neighbours/errors/non_enumberable_argument_error'
require 'closest_neighbours/errors/insufficient_groups_error'
require 'closest_neighbours/errors/non_integer_groups_error'

# Takes an array of elements, groups them by their ordered closest neighbors into n groups
module ClosestNeighbours
  #
  # Match array of times up into groups that are the closest to each other
  #
  # @param [Integer] groups The number of groups to create
  # @param [Array|Set|Enumerable] data The data set of items to group
  #
  # @return [Array] An array of `groups` groups
  #
  def self.times(groups, data)
    Times.new(groups, data).call
  end

  #
  # Match array of times up into groups that are the closest to each other
  #
  # @param [Integer] groups The number of groups to create
  # @param [Array|Set|Enumerable] data The data set of items to group
  #
  # @return [Array] An array of `groups` groups
  #
  def self.ordered(groups, data)
    Ordered.new(groups, data).call
  end
end
