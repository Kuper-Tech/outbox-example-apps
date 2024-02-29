# frozen_string_literal: true

# TODO: Move to sbmt-app?
HttpHealthCheck.configure do |c|
  HttpHealthCheck.add_builtin_probes(c)

  c.probe "/readiness/puma" do |env|
    [200, {}, [Puma.stats]]
  end

  c.probe "/readiness/schked" do |env|
    [200, {}, [Schked.worker.send(:scheduler).uptime_s]]
  end
end
