require 'bundler/setup'
require 'ps5_watcher'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  STORES_CONFIG_PATH = "#{File.dirname(__FILE__)}/fixtures/example_stores.yml".freeze
end
