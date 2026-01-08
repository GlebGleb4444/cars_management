# frozen_string_literal: true

require_relative 'autoload'

# Main program file
class Main
  def self.run
    repo = CarRepository.new

    params = Input.new.call
    cars = repo.all

    filtered = SearchEngine.new.filter(cars, params)
    sorted = Sorter.new.sort(filtered, params)

    history = SearchHistory.new
    history.save_search(params, sorted.length)

    ResultRenderer.show_search_results(sorted, history, params)
  end
end
