# frozen_string_literal: true

require_relative 'menu'

class UserMenu
  def initialize(main_program, menu)
    @main_program = main_program
    @menu = menu
  end

  def display
    puts "1. #{I18n.t('app.menu.search_car')}"
    puts "2. #{I18n.t('app.menu.show_all')}"
    puts "3. #{I18n.t('app.menu.help')}"
    puts "4. #{I18n.t('app.menu.my_searches')}"
    puts "5. #{I18n.t('app.menu.logout')}"
    puts "6. #{I18n.t('app.menu.exit')}"
  end

  def handle_choice(choice)
    case choice
    when '1', 'search', 'search a car' then @main_program.run_search
    when '2', 'show', 'show all cars' then @main_program.show_all_cars
    when '3', 'help' then @menu.display_help
    when '4', 'my searches', 'searches' then @main_program.show_my_searches
    when '5', 'logout', 'out' then @menu.logout
    when '6', 'exit', 'quit' then @menu.exit_program
    else
      puts I18n.t('app.invalid_option').red
    end
  end
end
