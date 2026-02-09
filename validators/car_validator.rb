# frozen_string_literal: true

class CarValidator
  attr_reader :car, :errors

  def initialize(car)
    @car = car
    @errors = []
  end

  def valid?
    @errors = []

    validate_string_field(:make, min: 3, max: 50, format: /\A[a-zA-Z\s-]+\z/)
    validate_string_field(:model, min: 2, max: 50, format: /\A[a-zA-Z0-9\s-]+\z/)

    validate_integer_field(:year, min: 1900, max: Date.today.year)
    validate_integer_field(:odometer, min: 0)
    validate_integer_field(:price, min: 0)

    validate_description(:description, max: 5000)

    @errors.empty?
  end

  private

  def validate_string_field(field, min:, max:, format:)
    value = car.public_send(field)

    return add_error(field, :required) if value.nil? || value.strip.empty?

    add_error(field, :min_length, min: min) if value.length < min
    add_error(field, :max_length, max: max) if value.length > max
    add_error(field, :format) unless value.match?(format)
  end

  def validate_integer_field(field, min: nil, max: nil)
    value = car.public_send(field)
    return add_error(field, :required) if value.nil? || value.to_s.strip.empty?

    value = Integer(value, exception: false)
    return add_error(field, :integer) unless value.is_a?(Integer)

    validate_integer_min(field, value, min)
    validate_integer_max(field, value, max)
  end

  def validate_integer_min(field, value, min)
    add_error(field, :min, min: min) if min && value < min
  end

  def validate_integer_max(field, value, max)
    add_error(field, :max, max: max) if max && value > max
  end

  def validate_description(field, max: 5000)
    value = car.public_send(field)
    return if value.nil?

    if value.is_a?(String)
      add_error(field, :max_length, max:) if value.length > max
    else
      add_error(field, :string)
    end
  end

  def add_error(field, type, **)
    @errors << I18n.t("errors.car.errors.#{field}.#{type}", **)
  end
end
