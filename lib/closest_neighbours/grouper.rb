# frozen_string_literal: true

require 'closest_neighbours/indexer'

module ClosestNeighbours
  # Split an Enumerable into specified number of groups containing the closest elements in each group.
  class Grouper
    def initialize(orderer: DefaultOrder.new)
      @orderer = orderer
    end

    def call(groups = 1, data = [])
      raise NonIntegerGroupsError unless groups.is_a? Integer
      raise NonEnumberableArgumentError unless data.is_a? Enumerable
      raise InsufficientGroupsError if groups < 1
      raise IncomparableElementError unless data.all? { |e| e <=> data.first }

      GrouperHelper.new(groups, orderer.call(data)).call
    end

    private

    attr_reader :orderer

    # Helper class to index data and extract ranges from an enumberble
    class GrouperHelper
      def initialize(groups, data)
        @groups = groups
        @data = data
      end

      def call
        if groups == 1
          [data]
        elsif groups >= data.count
          cells + blanks
        else
          ranges.map { |range| data[range] }
        end
      end

      private

      attr_reader :groups, :data

      def cells
        data.map { |x| [x] }
      end

      def blanks
        Array.new([0, groups - data.count].max, [])
      end

      def ranges
        Indexer.new(groups, data).call
               .each_cons(2)
               .map { |(left, right)| left...right }
      end
    end
  end
end
