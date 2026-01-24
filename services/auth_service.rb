# frozen_string_literal: true

require 'bcrypt'

require_relative '../models/user'
require_relative '../validators/email_validator'
require_relative '../validators/password_validator'

# Handles user authentication and registration logic.
class AuthService
  attr_reader :current_user

  def initialize
    @current_user = nil
  end

  def logged_in?
    !@current_user.nil?
  end

  def login(email, password)
    user = User.find_by_email(email)
    return error(:invalid_credentials) unless user&.authenticate?(password)

    @current_user = user
    success(:hello, email: user.email)
  end

  def signup(email, password)
    email_result = EmailValidator.validate!(email)
    return email_result unless email_result == true

    password_result = PasswordValidator.valid!(password)
    return password_result unless password_result == true

    password_hash = BCrypt::Password.create(password)
    user = User.new(email: email, password_hash: password_hash)
    return error(:signup_failed) unless user.save?

    @current_user = user
    success(:hello, email: email)
  end

  def logout
    return nil unless logged_in?

    email = @current_user.email
    @current_user = nil

    success(:goodbye, email: email)
  end

  private

  def success(key, params = {})
    I18n.t("app.#{key}", **params).green
  end

  def error(key)
    I18n.t("errors.auth.#{key}").red
  end
end
