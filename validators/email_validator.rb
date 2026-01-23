# frozen_string_literal: true

# Validates the format of user email addresses.
class EmailValidator
    EMAIL_REGEX = /\A[a-zA-Z0-9._%+-]{5,}@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/
  
    def self.validate!(email)
      return I18n.t('errors.email.invalid_format') unless EMAIL_REGEX.match?(email)
      return I18n.t('errors.email.already_exists') if User.find_by_email(email)
  
      nil
    end
  end