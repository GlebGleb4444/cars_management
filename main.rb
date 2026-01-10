# frozen_string_literal: true

require_relative 'autoload'

# Main program file
class Main
  def self.run
    # I18n setup
    I18n.load_path += Dir['./locales/*.yml']
    I18n.available_locales = %i[en ua]
    I18n.default_locale = :en

    # Choose language
    puts I18n.t('app.choose_language')
    choice = gets.strip

    locale_map = {
      '1' => :en,
      '2' => :ua
    }

    I18n.locale = locale_map[choice] || I18n.default_locale

    repo = CarRepository.new

    params = Input.new.ask_user_for_search_params
    cars = repo.all

    filtered = SearchEngine.new.filter(cars, params)
    sorted = Sorter.new.sort(filtered, params)

    history = SearchHistory.new
    history.save_search(params, sorted.length)

    existing = history.find_entry(params)

    renderer = ResultRenderer.new
    renderer.display_statistics(sorted, existing)
    renderer.display_results(sorted)
  end
end
