# frozen_string_literal: true

# Validates the strength and format of user passwords.
class PasswordValidator
  MIN_LENGTH = 8
  MAX_LENGTH = 20
  SPECIAL_CHARS_REGEX = %r{[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>/?]}

  def self.valid!(password)
    return I18n.t('errors.password.length') unless password.length.between?(MIN_LENGTH, MAX_LENGTH)
    return I18n.t('errors.password.uppercase') unless /[A-Z]/.match?(password)
    return I18n.t('errors.password.special_chars') if password.scan(SPECIAL_CHARS_REGEX).size < 2

    true
  end
end
