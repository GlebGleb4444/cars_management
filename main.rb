# Main program file

require_relative 'autoload'

class Main
  def self.run
    repo = CarRepository.new

    params = Input.new.call
    cars = repo.all

    filtered = SearchEngine.new.filter(cars, params)
    sorted = Sorter.new.sort(filtered, params)

    sorted.each { |car| puts car }
  end
end
