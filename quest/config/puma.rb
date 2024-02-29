# frozen_string_literal: true

app_root = File.expand_path(File.join(File.dirname(__FILE__), ".."))

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
env = ENV.fetch("RAILS_ENV", "development")
# bind ENV.fetch("PUMA_SOCKET", "unix://#{app_root}/tmp/sockets/puma.sock")

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
#
workers ENV.fetch("PUMA_CONCURRENCY", (env == "development") ? 0 : 10).to_i
worker_timeout (env == "production") ? 3600 : 10

threads_count = ENV.fetch("RAILS_MAX_THREADS", 2).to_i
threads(threads_count, threads_count)

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port ENV.fetch("PUMA_PORT", 3000)

# Specifies the `environment` that Puma will run in.
#
environment env

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PUMA_PIDFILE", "#{app_root}/tmp/pids/puma.pid")
state_path ENV.fetch("PUMA_STATEFILE", "#{app_root}/tmp/pids/puma.state")

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
preload_app!

on_worker_boot do
  SemanticLogger.reopen
end

# Allow puma to be restarted by `bin/rails restart` command.
activate_control_app ENV.fetch("PUMA_CTL_SOCKET", "unix:///var/run/pumactl.sock")
plugin :tmp_restart
plugin :yabeda
plugin :yabeda_prometheus
