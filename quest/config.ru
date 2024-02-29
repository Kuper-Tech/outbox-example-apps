require ::File.expand_path("../config/environment", __FILE__)

::HttpHealthCheck.run_server_async(port: ENV.fetch("HEALTH_CHECK_PORT").to_i)
run Rails.application
