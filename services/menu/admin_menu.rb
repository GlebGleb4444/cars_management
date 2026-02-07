# frozen_string_literal: true

require_relative 'menu'

class AdminMenu < Menu
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
    when '4', 'logout', 'out' then @main_menu.logout
    else
      puts I18n.t('app.invalid_option').red
    end
  end
end
