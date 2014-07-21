# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( print.css )
Rails.application.config.assets.precompile += %w( ie.css )
Rails.application.config.assets.precompile += %w( screen.css )
Rails.application.config.assets.precompile += %w( chart1.css )
Rails.application.config.assets.precompile += %w( chart2.css )

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
