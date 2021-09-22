# frozen_string_literal: true

module ClosestNeighbours
  # Determines the indexes where the data need to be grouped
  class Indexer
    def initialize(groups = 1, data = [])
      @groups = groups
      @data = data
    end

    def call
      [0] + indexes + [data.count]
    end

    private

    attr_reader :groups, :data

    def indexes
      if same?
        even
      else
        dynamic
      end
    end

    def same?
      differences_between_each_element.all? { |x| x == differences_between_each_element.first }
    end

    def even
      (1...groups).map do |i|
        i * (data.count / groups.to_f).ceil
      end
    end

    def dynamic
      differences_between_each_element
        .with_index
        .sort_by { |(diff, _)| -diff }
        .first(groups - 1)
        .map { |(_, i)| i + 1 }
        .sort
    end

    def differences_between_each_element
      data.lazy
          .each_cons(2)
          .map { |(lower, higher)| higher - lower }
    end
  end
end
