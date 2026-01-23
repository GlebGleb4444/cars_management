# frozen_string_literal: true

require 'bcrypt'
require 'yaml'

# Represents a user of the system with email and password attributes.
class User
  USERS_FILE = File.expand_path('../users.yml', __dir__).freeze

  attr_accessor :email
  attr_reader :password_hash

  def self.all
    return [] unless File.exist?(USERS_FILE)

    YAML.safe_load_file(USERS_FILE, permitted_classes: [], aliases: true) || []
  end

  def self.find_by_email(email)
    user_data = all.find { |user| user['email'] == email }
    return nil unless user_data

    new(email: user_data['email'], password_hash: user_data['password_hash'])
  end

  def initialize(email:, password: nil, password_hash: nil)
    @email = email

    if password
      @password_hash = BCrypt::Password.create(password)
    elsif password_hash
      @password_hash = password_hash
    else
      raise ArgumentError, 'password or password_hash must be provided'
    end
  end

  def save?
    users = self.class.all
    users << { 'email' => email, 'password_hash' => password_hash.to_s }
    File.write(USERS_FILE, users.to_yaml)
    true
  end

  def authenticate?(password)
    BCrypt::Password.new(password_hash) == password
  end
end
