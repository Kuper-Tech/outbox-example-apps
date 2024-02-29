# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = ENV["SENTRY_DSN"]
  config.breadcrumbs_logger = %i[active_support_logger http_logger]
  config.enabled_environments = %w[staging production]
  config.excluded_exceptions += %w[ActionController::RoutingError]
  config.traces_sample_rate = 1.0
  config.release = ENV["APP_VERSION"]
end
