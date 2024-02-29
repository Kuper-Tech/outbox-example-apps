# frozen_string_literal: true

Schked.config.tap do |config|
  config.redis = RedisConfig.connection_options(:db)
end
