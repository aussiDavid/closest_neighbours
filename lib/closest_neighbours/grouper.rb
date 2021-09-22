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

      if groups >= size
        individual_elements + blanks
      else
        ranges.map { |range| ordered_data[range] }
      end
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
      [0..indexes[0]] +
        (indexes + [size - 1]).each_cons(2)
                              .map { |(left, right)| (left + 1)..right }
    end

    def indexes
      @indexes ||= differences_with_indices
                   .lazy
                   .map(&:last)
                   .first(groups - 1)
                   .sort
    end

    def differences_between_each_pair
      ordered_data.each_cons(2).map { |(a, b)| b - a }
    end

    def differences_with_indices
      differences_between_each_pair
        .map.with_index { |x, i| [x, i] }
        .sort
        .reverse
    end

    def ordered_data
      @ordered_data ||= orderer.call(data)
    end

    def comparable_elements?
      data.all? { |e| data.first <=> e }
    end
  end
end
