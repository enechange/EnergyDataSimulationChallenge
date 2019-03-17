# frozen_string_literal: true

I18n.config.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
