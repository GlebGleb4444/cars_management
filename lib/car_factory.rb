# frozen_string_literal: true

require 'securerandom'
require 'ffaker'
require 'date'
require_relative '../models/car'

class CarFactory
  def self.random_car
    Car.new(
      'id' => SecureRandom.uuid,
      'make' => FFaker::Vehicle.make,
      'model' => FFaker::Vehicle.model,
      'year' => rand(1995..2024),
      'odometer' => rand(0..200_000),
      'price' => rand(3_000..50_000),
      'description' => FFaker::Lorem.sentence,
      'date_added' => Date.today.strftime('%d/%m/%y')
    )
  end
end
