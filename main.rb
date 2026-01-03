# Main program file

require_relative 'utils/input'
require_relative 'services/car_repository.rb'
require_relative 'services/search_engine.rb'
require_relative 'services/sorter.rb'

class Main
    def self.run
      repo = CarRepository.new

      params = Input.new.ask_user_for_search_params
      cars = repo.all

      filtered = SearchEngine.new.filter(cars, params)
      sorted = Sorter.new.sort(filtered, params)

      sorted.each { |car| puts car }
    end
end
  
