# frozen_string_literal: true

# Handles the main menu and user actions for the car search program.
class Menu
  def initialize(main_program, auth)
    @main_program = main_program
    @auth = auth
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
    if @auth.logged_in?
      handle_logged_in_user(choice)
    else
      handle_guest(choice)
    end
  end

  def display_welcome
    puts I18n.t('app.welcome_message').green
  end

  def display_menu
    puts "\n#{I18n.t('app.main_menu')}".yellow
    display_options
    print '> '
  end

  def display_options
    display_common_options
    @auth.logged_in? ? display_user_options : display_guest_options
  end

  def display_common_options
    puts "1. #{I18n.t('app.menu.search_car')}"
    puts "2. #{I18n.t('app.menu.show_all')}\n3. #{I18n.t('app.menu.help')}"
  end

  def display_user_options
    puts "4. #{I18n.t('app.menu.my_searches')}"
    puts "5. #{I18n.t('app.menu.logout')}\n6. #{I18n.t('app.menu.exit')}"
  end

  def display_guest_options
    puts "4. #{I18n.t('app.menu.login')}"
    puts "5. #{I18n.t('app.menu.signup')}\n6. #{I18n.t('app.menu.exit')}"
  end

  def handle_guest(choice)
    case choice
    when '1', 'search', 'search a car' then @main_program.run_search
    when '2', 'show', 'show all cars' then @main_program.show_all_cars
    when '3', 'help' then display_help
    when '4', 'login', 'log' then login
    when '5', 'signup', 'reg' then signup
    when '6', 'exit', 'quit' then exit_program
    else
      invalid_option
    end
  end

  def handle_logged_in_user(choice)
    case choice
    when '1', 'search', 'search a car' then @main_program.run_search
    when '2', 'show', 'show all cars' then @main_program.show_all_cars
    when '3', 'help' then display_help
    when '4', 'my searches', 'searches' then @main_program.show_my_searches
    when '5', 'logout', 'out' then logout
    when '6', 'exit', 'quit' then exit_program
    else
      invalid_option
    end
  end

  def display_help
    puts I18n.t('app.help_text')
  end

  def login
    email, password = prompt_credentials
    puts @auth.login(email, password)
  end

  def signup
    email, password = prompt_credentials
    puts @auth.signup(email, password)
  end

  def logout
    message = @auth.logout
    puts message if message
  end

  def prompt_credentials
    print I18n.t('app.enter_email')
    email = gets.strip
    print I18n.t('app.enter_password')
    password = gets.strip
    [email, password]
  end

  def exit_program
    puts I18n.t('app.exit_message')
    :exit
  end

  def invalid_option
    puts I18n.t('app.invalid_option').red
  end
end
