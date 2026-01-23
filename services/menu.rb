# frozen_string_literal: true

# Handles the main menu and user actions for the car search program.
class Menu
  def initialize(main_program)
    @main_program = main_program
  end

  def start
    display_welcome
    loop do
      choice = user_choice
      break if handle_user_choice(choice) == :exit
    end
  end

  private

  def user_choice
    display_menu
    gets.strip.downcase
  end

  def handle_user_choice(choice)
    case choice
    when '1', 'search', 'search a car' then @main_program.run_search
    when '2', 'show', 'show all cars' then  @main_program.show_all_cars
    when '3', 'help' then puts I18n.t('app.help_text')
    when '4', 'exit', 'quit'
      puts I18n.t('app.exit_message')
      :exit
    else
      puts I18n.t('app.invalid_option').red
    end
  end

  def display_welcome
    puts I18n.t('app.welcome_message').green
  end

  def display_menu
    puts "\n#{I18n.t('app.main_menu')}".yellow
    puts "1. #{I18n.t('app.menu.search_car')}"
    puts "2. #{I18n.t('app.menu.show_all')}"
    puts "3. #{I18n.t('app.menu.help')}"
    puts "4. #{I18n.t('app.menu.exit')}"
    print '> '
  end
end
