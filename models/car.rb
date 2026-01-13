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
      format_index(index),
      format_id,
      format_make,
      format_model,
      format_year,
      format_odometer,
      format_price,
      format_date_added
    ]
  end

  private

  def format_index(index)
    (index + 1).to_s.light_blue
  end

  def format_id
    id.to_s.light_blue
  end

  def format_make
    make.yellow
  end

  def format_model
    model.yellow
  end

  def format_year
    year.to_s.green
  end

  def format_odometer
    odometer.to_s
  end

  def format_price
    price.to_s.green
  end

  def format_date_added
    date_added.to_s.red
  end
end
