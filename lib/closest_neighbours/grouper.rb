# frozen_string_literal: true

module ClosestNeighbours
  # Split an Enumerable into specified number of groups containing the closest elements in each group.
  class Grouper
    def initialize(orderer: DefaultOrder.new)
      @orderer = orderer
    end

    def call(groups = 1, data = [])
      @groups = groups
      @data = data

      validate

      return [ordered_data] if groups == 1
      return individual_elements + blanks if groups >= size

      ranges.map { |range| ordered_data[range] }
    end

    private

    attr_reader :groups, :data, :orderer

    def validate
      raise NonIntegerGroupsError unless groups.is_a? Integer
      raise NonEnumberableArgumentError unless data.is_a? Enumerable
      raise InsufficientGroupsError if groups < 1
      raise IncomparableElementError unless comparable_elements?
    end

    def size
      data.count
    end

    def blanks
      Array.new(number_of_blanks, [])
    end

    def number_of_blanks
      [0, groups - size].max
    end

    def individual_elements
      ordered_data.map { |x| [x] }
    end

    def ranges
      [Range.new(nil, indexes.first)] +
        indexes.each_cons(2)
               .map { |(left, right)| Range.new(left + 1, right) } +
        [Range.new(indexes.last + 1, nil)]
    end

    def indexes
      @indexes ||= if evenly_spaced_elements?
                     evenly_spaced_indexes
                   else
                     indexes_by_changes_in_distance
                   end
    end

    def evenly_spaced_elements?
      differences_between_each_pair.all? { |x| x == differences_between_each_pair.first }
    end

    def evenly_spaced_indexes
      (groups - 1).times.map do |group|
        ((group + 1) * (size - 1)) / groups
      end
    end

    def indexes_by_changes_in_distance
      differences_with_indices
        .lazy
        .map(&:last)
        .first(groups - 1)
        .sort
    end

    def differences_between_each_pair
      ordered_data.lazy.each_cons(2).map { |(lower, higher)| higher - lower }
    end

    def differences_with_indices
      differences_between_each_pair
        .with_index
        .sort
        .reverse
    end

    def ordered_data
      @ordered_data ||= orderer.call(data)
    end

    def comparable_elements?
      data.all? { |e| e <=> data.first }
    end
  end
end
