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

  def exit_program
    puts I18n.t('app.exit_message')
    :exit
  end

  private

  def display_welcome
    puts I18n.t('app.welcome_message').green
  end

  def user_choice
    display_menu
    gets.strip.downcase
  end

  def display_menu
    puts "\n#{I18n.t('app.main_menu')}".yellow
    display_options
    print '> '
  end

  def display_options
    if @auth.logged_in?
      menu = @auth.current_user.admin? ? AdminMenu.new(@main_program, self) : UserMenu.new(@main_program, self)
      menu.display
    else
      GuestMenu.new(@main_program, self).display
    end
  end

  def handle_user_choice(choice)
    if @auth.logged_in?
      if @auth.current_user.admin?
        AdminMenu.new(@main_program, self).handle_choice(choice)
      else
        UserMenu.new(@main_program, self).handle_choice(choice)
      end
    else
      GuestMenu.new(@main_program, self).handle_choice(choice)
    end
  end

  def invalid_option
    puts I18n.t('app.invalid_option').red
  end

  def prompt_credentials
    print I18n.t('app.enter_email')
    email = gets.strip
    print I18n.t('app.enter_password')
    password = gets.strip
    [email, password]
  end
end

class AdminMenu
  def initialize(main_program, menu)
    @main_program = main_program
    @menu = menu
  end

  def display
    puts "1. #{I18n.t('app.menu.create_ad')}"
    puts "2. #{I18n.t('app.menu.update_ad')}"
    puts "3. #{I18n.t('app.menu.delete_ad')}"
    puts "4. #{I18n.t('app.menu.logout')}"
  end

  def handle_choice(choice)
    case choice
    when '1' then @main_program.create_advertisement
    when '2' then @main_program.update_advertisement
    when '3' then @main_program.delete_advertisement
    when '4', 'logout', 'out' then @menu.logout
    else
      puts I18n.t('app.invalid_option').red
    end
  end
end

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

class GuestMenu
  def initialize(main_program, menu)
    @main_program = main_program
    @menu = menu
  end

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
