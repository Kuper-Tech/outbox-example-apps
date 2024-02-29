# frozen_string_literal: true

PRIMARY_REDIS = ConnectionPool::Wrapper.new(size: ENV.fetch("DATABASE_POOL_SIZE", 5).to_i) do
  Redis.new(RedisConfig.connection_options(:db))
end
