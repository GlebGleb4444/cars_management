# frozen_string_literal: true

# Handles displaying car search results and statistics
class Printer
  def display_my_searches(searches)
    if searches.empty?
      puts I18n.t('app.no_searches').yellow
    else
      puts I18n.t('app.my_searches').green
      searches.each_with_index do |entry, index|
        params = entry['params']
        formatted_params = params.map { |k, v| "#{k}: #{v}" }.join(', ')
        puts "#{index + 1}. #{formatted_params}"
      end
    end
  end

  def display_statistics(sorted, existing)
    stats_rows = [
      [I18n.t('app.total_quantity'), sorted.size.to_s.green],
      [I18n.t('app.requests_quantity'), existing ? existing['requests_quantity'].to_s.yellow : '0'.red]
    ]

    stats_table = Terminal::Table.new(
      title: I18n.t('app.statistics').green.bold,
      rows: stats_rows
    )

    puts stats_table
  end

  def display_results(sorted)
    rows = sorted.each_with_index.map { |car, i| car.to_table_row(i) }

    table = Terminal::Table.new(
      title: I18n.t('app.search_results').green.bold,
      headings: [
        I18n.t('table.number'), I18n.t('table.id'), I18n.t('table.make'), I18n.t('table.model'), I18n.t('table.year'),
        I18n.t('table.odometer'), I18n.t('table.price'), I18n.t('table.date_added')
      ],
      rows: rows
    )

    puts table
  end
end
