# frozen_string_literal: true

require_relative 'autoload'

# Main program file
class Main
  def self.run
    new.run
  end

  def run
    LanguageSelector.call
    perform_search_cycle
  end

  def perform_search_cycle
    cars = load_data
    params = user_input
    sorted = filter_and_sort_cars(cars, params)
    existed_entries = save_search_history(params, sorted)
    display_results_and_stats(sorted, existed_entries)
  end

  private

  def load_data
    CarRepository.new.all
  end

  def user_input
    Input.new.call
  end

  def filter_and_sort_cars(cars, params)
    filtered = SearchEngine.new.filter(cars, params)
    Sorter.new.sort(filtered, params)
  end

  def save_search_history(params, sorted)
    history = SearchHistory.new
    history.save_search(params, sorted.length)
    history.find_entry(params)
  end

  def display_results_and_stats(sorted, existed_entries)
    renderer = Printer.new
    renderer.display_statistics(sorted, existed_entries)
    renderer.display_results(sorted)
  end
end
