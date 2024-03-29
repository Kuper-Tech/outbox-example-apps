require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = ENV["CODE_RELOAD"] == "no"

  # Do not eager load code on boot.
  config.eager_load = ENV["EAGER_LOAD"] == "yes"

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if ENV["CACHE"] == "yes"
    config.cache_store = :redis_cache_store, {url: RedisConfig.connection_uri, expires_in: 5.minutes}
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  # config.action_mailer.raise_delivery_errors = false

  # config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "debug").to_s.downcase

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  unless ENV["DEV_SKIP_LISTEN_GEM"]
    config.file_watcher = ActiveSupport::EventedFileUpdateChecker
  end

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true

  config.rails_semantic_logger.semantic = false
  config.rails_semantic_logger.started = true
  config.rails_semantic_logger.processing = true
  config.rails_semantic_logger.rendered = true

  config.semantic_logger.add_appender(
    io: $stdout,
    level: config.log_level,
    formatter: config.rails_semantic_logger.format
  )

  config.hosts << ENV["VIRTUAL_HOST"] if ENV["VIRTUAL_HOST"]
end
