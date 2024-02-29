# frozen_string_literal: true

Rails.application.config.outbox.tap do |config|
  config.redis = RedisConfig.connection_options(:db_outbox)
end
