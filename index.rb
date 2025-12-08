# Index file to run the car search program.

# This program is a console-based car search service.
# It loads data from the db.yml file, where each car is stored as a hash, and converts them into objects of the Car class.
# The user enters search parameters (make, model, year from/to, price from/to) and sorting options (by price or date added, ascending or descending).
# The program first filters the cars based on the entered criteria, comparing strings (make, model) and numbers (year, price),
# then sorts the filtered array by the selected field using the sort_by method (for dates, it converts the string to a Date), and finally displays the results in a readable format with all the main car attributes.

require_relative 'main'

Main.run
