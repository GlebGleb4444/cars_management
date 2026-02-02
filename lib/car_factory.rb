# frozen_string_literal: true

require_relative '../autoload'

class CarFactory
  CAR_FIELD_PROMPTS = {
    make: 'input.make',
    model: 'input.model',
    year: 'input.year',
    odometer: 'input.odometer',
    price: 'input.price',
    description: 'input.description'
  }.freeze

  class << self

    def random_car
      Car.new(
        'id' => SecureRandom.uuid,
        'make' => FFaker::Vehicle.make,
        'model' => FFaker::Vehicle.model,
        'year' => rand(1995..2024),
        'odometer' => rand(0..200_000),
        'price' => rand(3_000..50_000),
        'description' => FFaker::Lorem.sentence,
        'date_added' => Date.today.strftime('%d/%m/%y')
      )
    end

    def build_from_input(existing_car = nil)
      puts "\n#{existing_car ? 'Updating existing car:' : 'Creating new car:'}".yellow

      attributes = CAR_FIELD_PROMPTS.each_with_object({}) do |(field, i18n_key), result|
       value = ask_field(field, i18n_key, existing_car)
       return nil if value == :exit

       result[field.to_s] = value
     end

      build_car(attributes, existing_car)
    end

    private

    def ask_field(field, i18n_key, existing_car)
      default_value = existing_car&.send(field)
      prompt = I18n.t(i18n_key).to_s
      prompt += " [#{default_value}]" if default_value
      print prompt

      input = gets.strip
      return :exit if input.downcase == 'exit'

      input = default_value.to_s if input.empty? && default_value

      %i[year odometer price].include?(field) ? input.to_i : input
    end

    def build_car(attrs, existing_car)
      Car.new(
        'id' => existing_car&.id || SecureRandom.uuid,
        'make' => attrs['make'],
        'model' => attrs['model'],
        'year' => attrs['year'],
        'odometer' => attrs['odometer'],
        'price' => attrs['price'],
        'description' => attrs['description'],
        'date_added' => existing_car&.date_added || Date.today.strftime('%d/%m/%y')
      )
    end
  end
end
