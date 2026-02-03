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

  def display_help
    puts I18n.t('app.help_text')
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
