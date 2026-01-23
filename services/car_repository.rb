# frozen_string_literal: true

require 'yaml'
require_relative '../models/car'

# Loads car data from YAML
class CarRepository
  DB_PATH = File.expand_path('../db.yml', __dir__).freeze

  def initialize(path: DB_PATH)
    @data = YAML.safe_load_file(path, permitted_classes: [], aliases: true)
  end

  def all
    @data.map { |item| Car.new(item) }
  end
end
