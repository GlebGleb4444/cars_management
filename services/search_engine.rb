# A simple search engine for filtering cars based on various parameters.

class SearchEngine
    def initialize(repo)
        @repo = repo
    end

    def filter(params)
        @repo.all.select do |car|
            (car.make.downcase == params["make"].downcase || params["make"].empty?) &&
            (car.model.downcase == params["model"].downcase || params["model"].empty?) &&
            (car.year.to_i >= params["year_from"].to_i || params["year_from"].empty?) &&
            (car.year.to_i <= params["year_to"].to_i || params["year_to"].empty?) &&
            (car.price.to_i >= params["price_from"].to_i || params["price_from"].empty?) &&
            (car.price.to_i <= params["price_to"].to_i || params["price_to"].empty?)
        end
    end
end