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
      (index + 1).to_s.light_blue,
      id.to_s.light_blue,
      make.yellow,
      model.yellow,
      year.to_s.green,
      odometer.to_s,
      price.to_s.green
    ]
  end
end
