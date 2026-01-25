# frozen_string_literal: true

require_relative 'autoload'

# Main program file
class Main
  def self.run
    new.run
  end

  def run
    LanguageSelector.call
    @auth_service = auth
    menu(self, @auth_service)
  end

  def run_search
    perform_search_cycle
  end

  def show_all_cars
    renderer = Printer.new
    renderer.display_results(load_data)
  end

  def show_my_searches
    history = UserSearchHistory.new
    searches = history.searches_for(@auth_service.current_user)
    renderer = Printer.new
    renderer.display_my_searches(searches)
  end

  private

  def auth
    AuthService.new
  end

  def perform_search_cycle
    params = user_input
    sorted = filter_and_sort_cars(params)
    existed_entries = save_search_history(params, sorted)
    save_user_search_history(params) if @auth_service.logged_in?
    display_results_and_stats(sorted, existed_entries)
  end

  def menu(main, auth_service)
    Menu.new(main, auth_service).start
  end

  def load_data
    CarRepository.new.all
  end

  def user_input
    Input.new.call
  end

  def filter_and_sort_cars(params)
    filtered = SearchEngine.new.filter(load_data, params)
    Sorter.new.sort(filtered, params)
  end

  def save_search_history(params, sorted)
    history = SearchHistory.new
    history.save_search(params, sorted.length)
    history.find_entry(params)
  end

  def save_user_search_history(params)
    history = UserSearchHistory.new
    history.save_search(@auth_service.current_user, params)
  end

  def display_results_and_stats(sorted, existed_entries)
    renderer = Printer.new
    renderer.display_statistics(sorted, existed_entries)
    renderer.display_results(sorted)
  end
end
