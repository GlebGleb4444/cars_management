# frozen_string_literal: true

# Handles displaying car search results and statistics
class ResultRenderer
  def self.show_search_results(sorted:, history:, params:)
    puts '-----------------------------------'
    puts 'Statistic:'
    puts "Total Quantity: #{sorted.size}"

    existing = history.find_entry(params)
    puts "Requests quantity: #{existing['requests_quantity']}" if existing

    puts '-----------------------------------'
    puts 'Search Results:'

    sorted.each { |car| puts car }
  end
end
