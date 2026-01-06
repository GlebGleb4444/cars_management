# Service to sort a list of cars based on given parameters.

require 'date'

class Sorter
  def sort(cars, params)
    field = params['sort_by'].to_s.downcase
    direction = params['sort_direction'].to_s.downcase

    sorted = cars.sort_by do |car|
      case field
      when 'price'
        car.price.to_i
      else
        Date.strptime(car.date_added, '%d/%m/%y')
      end
    end

    direction == 'asc' ? sorted : sorted.reverse
  end
end
