# frozen_string_literal: true

require 'i18n'

I18n.load_path += Dir['./locales/*.yml']
I18n.available_locales = %i[en ua]
I18n.default_locale = :en

require 'colorize'
require 'terminal-table'

require_relative 'utils/input'
require_relative 'services/car_repository'
require_relative 'services/search_engine'
require_relative 'services/sorter'
require_relative 'services/search_history'
require_relative 'services/printer'
require_relative 'services/language_selector'
