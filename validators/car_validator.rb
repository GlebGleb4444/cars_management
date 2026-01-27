# frozen_string_literal: true

class CarValidator
  attr_reader :car, :errors

  def initialize(car)
    @car = car
    @errors = []
  end

  def valid?
    @errors = []
    validate_make
    validate_model
    validate_year
    validate_odometer
    validate_price
    validate_description
    @errors.empty?
  end

  private

  def validate_make
    return add_error(:make, :required) if car.make.nil? || car.make.strip.empty?

    check_make_length
    check_make_format
  end

  def check_make_length
    @errors << I18n.t('errors.car.errors.make.min_length', min: 3) if car.make.length < 3
    @errors << I18n.t('errors.car.errors.make.max_length', max: 50) if car.make.length > 50
  end

  def check_make_format
    @errors << I18n.t('errors.car.errors.make.only_letters') unless car.make.match?(/\A[a-zA-Z]+\z/)
  end

  def validate_model
    return add_error(:model, :required) if car.model.nil? || car.model.strip.empty?

    check_model_length
    check_model_format
  end

  def check_model_length
    @errors << I18n.t('errors.car.errors.model.min_length', min: 2) if car.model.length < 2
    @errors << I18n.t('errors.car.errors.model.max_length', max: 50) if car.model.length > 50
  end

  def check_model_format
    @errors << I18n.t('errors.car.errors.model.only_letters_or_digits') unless car.model.match?(/\A[a-zA-Z0-9]+\z/)
  end

  def validate_year
    if year_empty?
      @errors << I18n.t('errors.car.errors.year.required')
    elsif !car.year.is_a?(Integer)
      @errors << I18n.t('errors.car.errors.year.integer')
    else
      validate_year_range
    end
  end

  def year_empty?
    car.year.nil?
  end

  def validate_year_range
    @errors << I18n.t('errors.car.errors.year.min', min: 1900) if car.year < 1900
    @errors << I18n.t('errors.car.errors.year.max') if car.year > Date.today.year
  end

  def validate_odometer
    if car.odometer.nil?
      @errors << I18n.t('errors.car.errors.odometer.required')
    elsif !car.odometer.is_a?(Integer)
      @errors << I18n.t('errors.car.errors.odometer.integer')
    elsif car.odometer.negative?
      @errors << I18n.t('errors.car.errors.odometer.min', min: 0)
    end
  end

  def validate_price
    if car.price.nil?
      @errors << I18n.t('errors.car.errors.price.required')
    elsif !car.price.is_a?(Integer)
      @errors << I18n.t('errors.car.errors.price.integer')
    elsif car.price.negative?
      @errors << I18n.t('errors.car.errors.price.min', min: 0)
    end
  end

  def validate_description
    return if car.description.nil?

    unless car.description.is_a?(String)
      @errors << I18n.t('errors.car.errors.description.string')
      return
    end
    @errors << I18n.t('errors.car.errors.description.max_length', max: 5000) if car.description.length > 5000
  end

  def add_error(field, type)
    @errors << I18n.t("errors.car.errors.#{field}.#{type}")
  end
end
