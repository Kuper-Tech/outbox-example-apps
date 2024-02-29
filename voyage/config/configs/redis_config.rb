# frozen_string_literal: true

require "uri"

class RedisConfig < ApplicationConfig
  config_name :redis
  env_prefix :redis

  attr_config :url, :db, :db_sidekiq, :db_outbox, :db_cache

  required :url, :db, :db_sidekiq, :db_outbox, :db_cache

  def connection_uri(db_name = :db)
    uri = URI(url)
    uri.path = "/#{public_send(db_name)}"
    uri.to_s
  end

  def connection_options(db_name = :db)
    {
      url: connection_uri(db_name),
      reconnect_attempts: [0, 0.05, 0.1, 0.5],
      db: public_send(db_name)
    }
  end
end
