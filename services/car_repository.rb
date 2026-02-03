# frozen_string_literal: true

require 'yaml'
require_relative '../models/car'

# Loads car data from YAML
class CarRepository
  DB_PATH = File.expand_path('../db.yml', __dir__).freeze

  def initialize
    @data = YAML.safe_load_file(DB_PATH, permitted_classes: [], aliases: true) || []
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

  def update_car(index, updated_car)
    cars = all
    return false unless cars[index]

    cars[index] = updated_car
    save_all(cars)
  end

  def delete_car(index)
    cars = all
    return false unless cars[index]

    cars.delete_at(index)
    save_all(cars)
  end

  def find(index)
    all[index]
  end

  private

  def save_all(cars)
    @data = cars.map(&:to_h).map { |h| h.transform_keys(&:to_s) }
    save!
  end

  def save!
    File.write(DB_PATH, @data.to_yaml)
  end
end
