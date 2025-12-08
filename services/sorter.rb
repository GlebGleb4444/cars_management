# Service to sort a list of cars based on given parameters.

require 'date'

class Sorter
    def sort(cars, params)
        field = params["sort_by"]
        direction = params["sort_direction"]

        sorted = if field == 'price'
            cars.sort_by { |car| car.price.to_i }
        else
            cars.sort_by { |car| Date.strptime(car.date_added, "%d/%m/%y") }
        end

        direction == 'asc' ? sorted.reverse : sorted
    end
end