require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "active_job/railtie"
# require "action_mailer/railtie"
# require "action_view/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# https://github.com/bkeepers/dotenv#what-other-env-files-can-i-use
if %w[development test].include?(ENV["RAILS_ENV"])
  Dotenv::Rails.load
end

module Voyage
  class Application < Rails::Application
    config.load_defaults 7.1

    config.api_only = true
    config.time_zone = "Moscow"

    config.i18n.available_locales = [:en]
    config.i18n.default_locale = :en

    config.active_job.queue_adapter = :sidekiq
  end
end
