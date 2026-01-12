require 'i18n'

I18n.load_path += Dir['./locales/*.yml']
I18n.available_locales = %i[en ua]
I18n.default_locale = :en
