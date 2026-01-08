# frozen_string_literal: true

require 'yaml'

class SearchHistory
  attr_reader :data

  DB_PATH = File.expand_path('../searches.yml', __dir__).freeze

  def initialize(path: DB_PATH)
    @path = path
    @data = File.exist?(path) ? YAML.safe_load(File.read(path), permitted_classes: [], aliases: true) : []
  end

  def save_search(params, total_results)
    entry_exists = @data.find { |entry| equal_search?(entry, params) }

    if entry_exists
      entry_exists['requests_quantity'] += 1
      entry_exists['total_results'] = total_results
    else
      new_entry = params.merge(
        'total_results' => total_results,
        'requests_quantity' => 1
      )
      @data << new_entry
    end

    save_data
  end

  def find_entry(params)
    @data.find { |entry| equal_search?(entry, params) }
  end

  private

  def save_data
    File.open(@path, 'w') { |f| f.write(YAML.dump(@data)) }
  end

  def equal_search?(entry, params)
    %w[make model min_price max_price min_year max_year].all? do |key|
      entry[key] == params[key]
    end
  end
end
