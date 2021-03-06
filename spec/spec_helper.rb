require 'simplecov'

SimpleCov.start do
  add_filter 'spec/'
  add_filter 'lib/csv_to_html/version'

  add_group 'Libraries', 'lib/'

  track_files '{lib}/**/*.rb'
end

SimpleCov.minimum_coverage 95

require 'bundler/setup'
require 'pry'
require 'fakefs/spec_helpers'
require 'csv_to_html'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
