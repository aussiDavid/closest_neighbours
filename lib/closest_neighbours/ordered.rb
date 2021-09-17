# frozen_string_literal: true

module ClosestNeighbours
  # Split an Enumerable into specified number of groups containing the closest elements in each group.
  class Ordered
    def initialize(groups = 1, data = [])
      @groups = groups
      @data = data
    end

    def call
      validate!

      if groups >= size
        wraped_data + blanks
      else
        ranges.map { |range| sorted_data[range] }
      end
    end

    private

    attr_reader :groups, :data

    def validate!
      raise NonIntegerGroupsError unless groups.is_a? Integer
      raise NonEnumberableArgumentError unless data.is_a? Enumerable
      raise InsufficientGroupsError if groups < 1
      raise IncomparableElementError unless comparable_elements?
    end

    def size
      data.to_a.size
    end

    def blanks
      Array.new(number_of_blanks, [])
    end

    def number_of_blanks
      [0, groups - size].max
    end

    def wraped_data
      sorted_data.map { |x| [x] }
    end

    def ranges
      [0..indexes[0]] +
        (indexes << size).each_cons(2)
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
      sorted_data.each_cons(2).map { |(a, b)| b - a }
    end

    def differences_with_indices
      differences_between_each_pair
        .map.with_index { |x, i| [x, i] }
        .sort
        .reverse
    end

    def sorted_data
      @sorted_data ||= data.to_a
    end

    def comparable_elements?
      data.all? { |e| data.first <=> e }
    end
  end
end
