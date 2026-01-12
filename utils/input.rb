# frozen_string_literal: true

# This class collects user input and builds a hash of car search parameters.

class Input
  SEARCH_FIELD_PROMPTS = {
    make: 'input.make',
    model: 'input.model',
    year_from: 'input.year_from',
    year_to: 'input.year_to',
    price_from: 'input.price_from',
    price_to: 'input.price_to'
  }.freeze

  SORT_OPTION_PROMPTS = {
    sort_by: 'input.sort_by',
    sort_direction: 'input.sort_direction'
  }.freeze

  def call
    puts I18n.t('input.select_rules')

    search_params = read_user_input(SEARCH_FIELD_PROMPTS)
    sort_params = read_user_input(SORT_OPTION_PROMPTS)

    search_params.merge(sort_params)
  end

  private

  def read_user_input(prompts_by_field)
    prompts_by_field.each_with_object({}) do |(field_name, i18n_key), user_input|
      puts I18n.t(i18n_key)
      user_input[field_name.to_s] = gets.strip
    end
  end
end
