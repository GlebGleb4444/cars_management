# A repository class to load car data from a YAML file

require 'yaml'
require_relative '../models/car'

class CarRepository
  DB_PATH = File.expand_path('../db.yml', __dir__).freeze

  def initialize(path: DB_PATH)
    @data = YAML.safe_load(File.read(path), permitted_classes: [], aliases: true)
  end

  def all
    @data.map { |item| Car.new(item) }
  end
end
