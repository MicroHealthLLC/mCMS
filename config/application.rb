require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MHRM
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # config.active_job.queue_adapter = :sidekiq

    config.i18n.load_path += Dir[Rails.root.join('engine', '**/config/locales', '**/*.{rb,yml}').to_s]
    config.autoload_paths += Dir[Rails.root.join('lib')]
    config.autoload_paths += Dir[Rails.root.join('lib/prawn/*.rb')]
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{*/}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'controllers/admin')]
    config.autoload_paths += Dir[Rails.root.join('app', 'controllers/cases')]
    config.autoload_paths += Dir[Rails.root.join('app', 'controllers/profiles')]
    config.autoload_paths += Dir[Rails.root.join('app', 'controllers/history')]
  end
end
