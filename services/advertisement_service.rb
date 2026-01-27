# frozen_string_literal: true

require_relative '../autoload'

class AdvertisementService
  def initialize(repository: CarRepository.new)
    @repository = repository
  end

  def create
    loop do
      car = CarFactory.build_from_input
      return unless car

      assign_system_fields(car)
      next unless valid_car?(car)

      @repository.add(car)
      puts I18n.t('admin.create_success', id: car.id).green
      break
    end
  end

  def update
    cars = @repository.all
    return puts I18n.t('admin.no_cars').red if cars.empty?

    index = choose_car(cars)
    return unless index

    old_car = cars[index]
    updated_car = CarFactory.build_from_input(old_car)
    return unless updated_car

    preserve_system_fields(old_car, updated_car)
    return unless valid_car?(updated_car)

    save_updated_car(index, updated_car)
  end

  def delete
    cars = @repository.all
    return puts I18n.t('admin.no_cars').red if cars.empty?

    index = choose_car(cars)
    return unless index

    if @repository.delete_car?(index)
      puts I18n.t('admin.delete_success', id: cars[index].id).green
    else
      puts I18n.t('app.invalid_option').red
    end
  end

  private

  def assign_system_fields(car)
    car.instance_variable_set(:@id, SecureRandom.uuid)
    car.instance_variable_set(:@date_added, Time.now.strftime('%d/%m/%y'))
  end

  def preserve_system_fields(old_car, new_car)
    new_car.instance_variable_set(:@id, old_car.id)
    new_car.instance_variable_set(:@date_added, old_car.date_added)
  end

  def valid_car?(car)
    validator = CarValidator.new(car)
    return true if validator.valid?

    print_validation_errors(validator)
    false
  end

  def print_validation_errors(validator)
    puts I18n.t('admin.validation_errors').red
    validator.errors.each { |e| puts "- #{e}".red }
    puts "#{I18n.t('app.retry')}\n\n" if I18n.exists?('app.retry')
  end

  def choose_car(cars)
    display_cars(cars)
    print I18n.t('admin.select_number')

    input = gets.strip
    return if input.downcase == 'exit'

    parse_car_index(input, cars.size)
  end

  def display_cars(cars)
    cars.each_with_index do |car, i|
      puts "#{i + 1}. #{car.make} #{car.model} (#{car.year})"
    end
  end

  def parse_car_index(input, max)
    index = input.to_i - 1
    if index.between?(0, max - 1)
      index
    else
      puts I18n.t('app.invalid_option').red
      nil
    end
  end

  def save_updated_car(index, updated_car)
    @repository.update_car?(index, updated_car)
    puts I18n.t('admin.update_success', id: updated_car.id).green
  end
end
