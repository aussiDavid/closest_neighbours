# frozen_string_literal: true

require 'closest_neighbours/version'
require 'closest_neighbours/ordered'

# Errors
require 'closest_neighbours/errors/non_enumberable_argument_error'
require 'closest_neighbours/errors/insufficient_groups_error'
require 'closest_neighbours/errors/non_integer_groups_error'

# Takes an array of elements, groups them by their ordered closest neighbors into n groups
module ClosestNeighbours
  #
  # Split an Enumerable into specified number of groups containing the closest elements in each group.
  #
  # @example
  #
  #   ClosestNeighbours.ordered(2, [10, 2, 11, 5])
  #   # => [[2, 5], [10, 11]]
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
