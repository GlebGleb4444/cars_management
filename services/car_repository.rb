# frozen_string_literal: true

require 'yaml'
require_relative '../models/car'

# Loads car data from YAML
class CarRepository
  DB_PATH = File.expand_path('../db.yml', __dir__).freeze

  def initialize(path: DB_PATH)
    @path = path
    @data = YAML.safe_load_file(path, permitted_classes: [], aliases: true) || []
  end

  def all
    @data.map { |item| Car.new(item) }
  end

  def add(car)
    @data << car.to_h.transform_keys(&:to_s)
    save!
  end

  def clear
    @data = []
    save!
  end

  private

  def save!
    File.write(@path, @data.to_yaml)
  end
end
