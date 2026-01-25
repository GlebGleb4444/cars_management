# frozen_string_literal: true

require 'colorize'
require 'terminal-table'
require 'bcrypt'
require 'yaml'
require 'rake'
require 'ffaker'
require 'securerandom'
require 'date'

require_relative 'config/i18n'
require_relative 'services/language_selector'

require_relative 'utils/input'

require_relative 'models/user'
require_relative 'validators/email_validator'
require_relative 'validators/password_validator'

require_relative 'services/car_repository'
require_relative 'services/search_engine'
require_relative 'services/search_history'
require_relative 'services/sorter'
require_relative 'services/printer'
require_relative 'services/menu'
require_relative 'services/auth_service'
require_relative 'services/user_search_history'
