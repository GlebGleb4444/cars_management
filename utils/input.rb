# This class handles user input for car search parameters.

class Input
    def ask_user_for_search_params

        puts "Please select search rules."
        
        puts "Please choose make:"
        make_user = gets.strip

        puts "Please choose model:"
        model_user = gets.strip

        puts "Please choose year_from:"
        year_from_user = gets.strip

        puts "Please choose year_to:"
        year_to_user = gets.strip

        puts "Please choose price_from:"
        price_from_user = gets.strip

        puts "Please choose price_to:"
        price_to_user = gets.strip

        puts "Please choose sort option (date_added|price):"
        sort_by = gets.strip

        puts "Please choose sort direction(desc|asc):"
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
end
