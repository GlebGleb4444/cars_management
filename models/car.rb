# frozen_string_literal: true

# Car model to represent a car listing
class Car
  attr_reader :id, :make, :model, :year, :odometer, :price, :description, :date_added

  def initialize(car_attr)
    @id = car_attr['id']
    @make = car_attr['make']
    @model = car_attr['model']
    @year = car_attr['year']
    @odometer = car_attr['odometer']
    @price = car_attr['price']
    @description = car_attr['description']
    @date_added = car_attr['date_added']
  end

  def to_table_row(index)
    [
      colorize(index + 1, :light_blue),
      colorize(id, :light_blue),
      colorize(make, :yellow),
      colorize(model, :yellow),
      colorize(year, :green),
      odometer.to_s,
      colorize(price, :green),
      colorize(date_added, :red)
    ]
  end

  private

  def colorize(value, color)
    value.to_s.public_send(color)
  end
end
