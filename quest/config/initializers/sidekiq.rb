# frozen_string_literal: true

require "sidekiq/web"

Sidekiq.configure_server do |config|
  config.redis = RedisConfig.connection_options(:db_sidekiq)

  ::HttpHealthCheck.run_server_async(port: ENV.fetch("HEALTH_CHECK_PORT").to_i)
end

Sidekiq.configure_client do |config|
  config.redis = RedisConfig.connection_options(:db_sidekiq)
end
