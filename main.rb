
require_relative 'autoload'

# Main program file
class Main
    def self.run
      repo = CarRepository.new

      params = Input.new.call
      cars = repo.all

      filtered = SearchEngine.new.filter(cars, params)
      sorted = Sorter.new.sort(filtered, params)

      history = SearchHistory.new
      history.save_search(params, sorted.length)

      puts "-----------------------------------"
      puts "Statistic:"
      puts "Total Quantity: #{sorted.size}"

      existing = history.find_entry(params)
      puts "Requests quantity: #{existing['requests_quantity']}" if existing
      puts "-----------------------------------"

      puts "Search Results:"
      sorted.each { |car| puts car }
    end
end
