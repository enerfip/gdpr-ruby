# frozen_string_literal: true

require "bundler/setup"

Bundler.require :tools, :development, :test

Dotenv.load

Combustion.initialize! :active_record

require 'rspec/rails'

require "simplecov"
SimpleCov.start { enable_coverage :branch }

require "gdpr"

GC.auto_compact = true
GC.verify_compaction_references double_heap: true, toward: :empty

Dir[File.join(__dir__, "support", "shared_contexts", "**/*.rb")].sort.each { |path| require path }

RSpec.configure do |config|
  config.color = true
  config.disable_monkey_patching!
  config.example_status_persistence_file_path = "./tmp/rspec-examples.txt"
  config.filter_run_when_matching :focus
  config.formatter = ENV["CI"] == "true" ? :progress : :documentation
  config.order = :random
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.warnings = true

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
    mocks.verify_partial_doubles = true
  end

  config.use_transactional_fixtures = true
end
