# frozen_string_literal: true

require_relative 'autoload'

# Main program file
class Main
  def self.run
    LanguageSelector.call

    repo = CarRepository.new

    params = Input.new.call
    cars = repo.all

    filtered = SearchEngine.new.filter(cars, params)
    sorted = Sorter.new.sort(filtered, params)

    history = SearchHistory.new
    history.save_search(params, sorted.length)

    existed_entries = history.find_entry(params)

    renderer = Printer.new
    renderer.display_statistics(sorted, existed_entries)
    renderer.display_results(sorted)
  end
