# frozen_string_literal: true

require_relative 'menu'

class GuestMenu < Menu
  def display
    puts "1. #{I18n.t('app.menu.search_car')}"
    puts "2. #{I18n.t('app.menu.show_all')}"
    puts "3. #{I18n.t('app.menu.help')}"
    puts "4. #{I18n.t('app.menu.login')}"
    puts "5. #{I18n.t('app.menu.signup')}"
    puts "6. #{I18n.t('app.menu.exit')}"
  end

  def handle_choice(choice)
    case choice
    when '1', 'search', 'search a car' then @main_program.run_search
    when '2', 'show', 'show all cars' then @main_program.show_all_cars
    when '3', 'help' then @menu.display_help
    when '4', 'login', 'log' then @menu.login
    when '5', 'signup', 'reg' then @menu.signup
    when '6', 'exit', 'quit' then @menu.exit_program
    else
      puts I18n.t('app.invalid_option').red
    end
  end
end
