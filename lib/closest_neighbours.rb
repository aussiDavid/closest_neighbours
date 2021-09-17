# frozen_string_literal: true

require 'closest_neighbours/version'
require 'closest_neighbours/unordered'

# Errors
require 'closest_neighbours/errors/non_enumberable_argument_error'
require 'closest_neighbours/errors/insufficient_groups_error'
require 'closest_neighbours/errors/non_integer_groups_error'
require 'closest_neighbours/errors/incomparable_element_error'

# Top level model for Closest Neighbours gem
module ClosestNeighbours
  #
  # Split an Enumerable into specified number of groups containing the closest elements in each group.
  #
  # @example
  #
  #   ClosestNeighbours.group(2, [10, 2, 11, 5])
  #   # => [[2, 5], [10, 11]]
  #
  # @param [Integer] groups The number of groups to create
  # @param [Enumerable] data The data set of items to group
  #
  # @return [Array] An array of `groups` groups
  #
  def self.group(groups, data)
    Unordered.new(groups, data).call
  end
end
