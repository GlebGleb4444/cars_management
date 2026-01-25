# frozen_string_literal: true

require_relative 'autoload'
require_relative 'lib/car_factory'

namespace :db do
  desc 'Clear the cars database'
  task :clear do
    CarRepository.new.clear
    puts 'Database has been cleared'
  end

  desc 'Add one random car'
  task :add_one do
    CarRepository.new.add(CarFactory.random_car)
    puts 'Added 1 car'
  end

  desc 'Add multiple random cars: rake db:add_many[10]'
  task :add_many, [:count] do |_, args|
    count = [args[:count].to_i, 1].max
    repo = CarRepository.new
    count.times { repo.add(CarFactory.random_car) }
    puts "Added #{count} cars"
  end
end
