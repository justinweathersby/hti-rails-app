require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HtiRailsApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Checks for a local_env file in config to set local enviroment variables
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end

    # Fix for CORS issue
    config.middleware.insert_before 0, Rack::Cors do
     allow do
       origins '*'
       resource '*',
        :headers => :any,
        :methods => [:get, :post, :options, :delete, :put],
        :expose  => ['access-token', 'expiry', 'token-type', 'uid', 'client']
     end
    end

    # Devise form error
    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      html_tag.html_safe
    }
  end
end
