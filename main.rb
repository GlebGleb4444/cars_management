# frozen_string_literal: true

require_relative 'autoload'

# Main program file
class Main
  def self.run
    new.run
  end

  def run
    LanguageSelector.call
    load_data
    user_input
    filter_and_sort_cars
    save_search_history
    display_results_and_stats
  end

  private

  def load_data
    @repo = CarRepository.new
    @cars = @repo.all
  end

  def user_input
    @params = Input.new.call
  end

  def filter_and_sort_cars
    @filtered = SearchEngine.new.filter(@cars, @params)
    @sorted = Sorter.new.sort(@filtered, @params)
  end

  def save_search_history
    history = SearchHistory.new
    history.save_search(@params, @sorted.length)
    @existed_entries = history.find_entry(@params)
  end

  def display_results_and_stats
    renderer = Printer.new
    renderer.display_statistics(@sorted, @existed_entries)
    renderer.display_results(@sorted)
  end
end
