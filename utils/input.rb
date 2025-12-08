# This class handles user input for car search parameters.

class Input
    def ask_user_for_search_params
        
        puts "Enter car make:"
        make_user = gets.strip

        puts "Enter car model:"
        model_user = gets.strip

        puts "Enter car year from:"
        year_from_user = gets.strip

        puts "Enter car year to:"
        year_to_user = gets.strip

        puts "Enter car price from:"
        price_from_user = gets.strip

        puts "Enter car price to:"
        price_to_user = gets.strip

        puts "How to sort results? (enter 'price', 'date_added' or leave blank for no sorting):"
        sort_by = gets.strip

        puts "Direction? (enter 'asc' for ascending, 'desc' for descending or leave blank for no sorting):"
        sort_direction = gets.strip

        # Car user input hash
        {
            "make" => make_user,
            "model" => model_user,
            "year_from" => year_from_user,
            "year_to" => year_to_user,
            "price_from" => price_from_user, 
            "price_to" => price_to_user
        }

    end
end