# frozen_string_literal: true

# This class collects user input and builds a hash of car search parameters.

class Input
  def ask_user_for_search_params
        
    puts I18n.t("input.make")
    make_user = gets.strip

    puts I18n.t("input.model")
    model_user = gets.strip

    puts I18n.t("input.year_from")
    year_from_user = gets.strip

    puts I18n.t("input.year_to")
    year_to_user = gets.strip

    puts I18n.t("input.price_from")
    price_from_user = gets.strip

    puts I18n.t("input.price_to")
    price_to_user = gets.strip

    puts I18n.t("input.sort_by")
    sort_by = gets.strip

    puts I18n.t("input.sort_direction")
    sort_direction = gets.strip

    # Car user input hash
    {
        "make" => make_user,
        "model" => model_user,
        "year_from" => year_from_user,
        "year_to" => year_to_user,
        "price_from" => price_from_user, 
        "price_to" => price_to_user,
        "sort_by" => sort_by,
        "sort_direction" => sort_direction
    }
  end

  def read_user_input(prompts_by_field)
    prompts_by_field.each_with_object({}) do |(field_name, prompt_text), user_input|
      puts prompt_text
      user_input[field_name.to_s] = gets.strip
    end
  end
end
