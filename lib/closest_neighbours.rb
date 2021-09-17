# frozen_string_literal: true

require 'closest_neighbours/version'
require 'closest_neighbours/grouper'

# Plugable Roles
require 'closest_neighbours/orderers/sorted_order'
require 'closest_neighbours/orderers/default_order'

# Errors
require 'closest_neighbours/errors/non_enumberable_argument_error'
require 'closest_neighbours/errors/insufficient_groups_error'
require 'closest_neighbours/errors/non_integer_groups_error'
require 'closest_neighbours/errors/incomparable_element_error'

# Top level model for Closest Neighbours gem
module ClosestNeighbours
  #
  # Split an Enumerable into specified number of groups containing the closest elements in each group using the most general purpose algorithm.
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
    Grouper.new(groups, data, orderer: SortedOrder.new).call
  end

  #
  # Split a sorted Enumerable into specified number of groups containing the closest elements in each group.
  #
  # @example
  #
  #   ClosestNeighbours.ordered_group(2, [2, 5, 10, 11])
  #   # => [[2, 5], [10, 11]]
  #
  # @param [Integer] groups The number of groups to create
  # @param [Enumerable] ordered_data The data set of items to group
  #
  # @return [Array] An array of `groups` groups
  #
  def self.ordered_group(groups, ordered_data)
    Grouper.new(groups, ordered_data, orderer: DefaultOrder.new).call
  end
end
