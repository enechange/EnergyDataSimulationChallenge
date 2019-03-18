# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module OsamuTakiya
  class Application < Rails::Application
    config.load_defaults 5.2

    config.time_zone = 'Asia/Tokyo'
    config.active_record.default_timezone = :utc
    config.generators.template_engine = :slim

    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: true,
                       request_specs: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
end
