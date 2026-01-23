# frozen_string_literal: true

# Handles language selection for the application
class LanguageSelector
  LOCALE_MAP = {
    '1' => :en,
    '2' => :ua
  }.freeze

  def self.call
    puts I18n.t('app.choose_language')
    choice = gets.strip
    I18n.locale = LOCALE_MAP[choice] || I18n.default_locale
  end
end
