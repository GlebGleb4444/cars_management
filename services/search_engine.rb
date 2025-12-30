# A simple search engine for filtering cars based on various parameters.

class SearchEngine
    def filter(cars, params)
        cars.select do |car|
            filter_by(car.make, params["make"]) &&
            filter_by(car.model, params["model"]) &&
            filter_range(car.year, params["year_from"], params["year_to"]) &&
            filter_range(car.price, params["price_from"], params["price_to"])
        end
    end

    private

    def filter_by(value, query)
        query.empty? || value.downcase == query.downcase
    end

    def filter_range(value, from, to)
        (from.empty? || value.to_i >= from.to_i) &&
        (to.empty? || value.to_i <= to.to_i)
    end
end
