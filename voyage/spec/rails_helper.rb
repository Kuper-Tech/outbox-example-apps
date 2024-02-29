# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

require "bundler/setup"

begin
  require File.expand_path("../../config/environment", __FILE__)
rescue => e
  # Fail fast if application couldn't be loaded
  $stdout.puts "Failed to load the app: #{e.message}\n#{e.backtrace.take(5).join("\n")}"
  exit(1)
end

require "rspec/rails"
require "faker"
require "test_prof/recipes/rspec/before_all"
require "test_prof/recipes/rspec/let_it_be"

Dir["#{__dir__}/support/**/*.rb"].sort.each { |f| require f }

Faker::Config.random = Random.new(0xCAFEBABE)

RSpec.configure do |config|
  # Add `travel_to`
  config.include ActiveSupport::Testing::TimeHelpers
  # Add `fixture_file_upload`
  config.include ActionDispatch::TestProcess::FixtureFile
  config.include Shoulda::Matchers::ActiveModel
  config.include FactoryBot::Syntax::Methods

  config.fixture_path = Rails.root.join("spec/fixtures")
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.after do
    Rails.cache.clear
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
