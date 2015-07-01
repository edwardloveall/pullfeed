if ENV.fetch('COVERAGE', false)
  require 'simplecov'
  SimpleCov.start 'rails'
end

require 'webmock/rspec'

# http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.order = :random
  config.run_all_when_everything_filtered = true
end

WebMock.disable_net_connect!(allow_localhost: true)
