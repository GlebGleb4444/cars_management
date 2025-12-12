# frozen_string_literal: true

require 'date'

# Service to sort a list of cars based on given parameters.
class Sorter
  def sort(cars, params)
    field = params['sort_by'].to_s.downcase
    direction = params['sort_direction'].to_s.downcase

        sorted = if field == 'price'
            cars.sort_by { |car| car.price.to_i }
        else
            cars.sort_by { |car| Date.strptime(car.date_added, "%d/%m/%y") }
        end

        direction == 'asc' ? sorted : sorted.reverse
    end

    direction == 'asc' ? sorted : sorted.reverse
  end
end
