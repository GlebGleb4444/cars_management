# frozen_string_literal: true

# Service to manage user search history stored in a YAML file.
class UserSearchHistory
  DB_PATH = File.expand_path('../user_searches.yml', __dir__).freeze

  def initialize(path: DB_PATH)
    @path = path

    @data = []

    return unless File.exist?(@path)

    @data = YAML.safe_load_file(path, permitted_classes: [], aliases: true) || []
  end

  def save_search(user, params)
    @data << {
      'user_email' => user.email,
      'params' => params
    }
    save_data
  end

  def searches_for(user)
    @data.select { |entry| entry['user_email'] == user.email }
  end

  private

  def save_data
    File.write(@path, YAML.dump(@data))
  end
end
