# A repository class to load car data from a YAML file

require 'yaml'
require_relative '../models/car'

class CarRepository
    def initialize(path)
        @data = YAML.load_file(path)
    end

    def all
        @data.map { |item| Car.new(item) }
    end
end
