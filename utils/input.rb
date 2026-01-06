# This class collects user input and builds a hash of car search parameters.

class Input
  SEARCH_FIELD_PROMPTS = {
    make: 'Please choose make:',
    model: 'Please choose model:',
    year_from: 'Please choose year_from:',
    year_to: 'Please choose year_to:',
    price_from: 'Please choose price_from:',
    price_to: 'Please choose price_to:'
  }.freeze

  SORT_OPTION_PROMPTS = {
    sort_by: 'Please choose sort option (date_added|price):',
    sort_direction: 'Please choose sort direction(desc|asc):'
  }.freeze

  def call
    puts 'Please select search rules.'

    search_params = read_user_input(SEARCH_FIELD_PROMPTS)
    sort_params = read_user_input(SORT_OPTION_PROMPTS)

    search_params.merge(sort_params)
  end

  private

  def read_user_input(prompts_by_field)
    prompts_by_field.each_with_object({}) do |(field_name, prompt_text), user_input|
      puts prompt_text
      user_input[field_name.to_s] = gets.strip
    end
  end
end
