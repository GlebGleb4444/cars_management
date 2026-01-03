# A repository class to load car data from a YAML file

require 'yaml'
require_relative '../models/car'

class CarRepository
    DB_PATH = 'db.yml'
    
    def initialize(path: DB_PATH)
        @data = YAML.safe_load(File.read(path), permitted_classes: [Date, Time], aliases: true)
    end

    def all
        @data.map { |item| Car.new(item) }
    end
end
