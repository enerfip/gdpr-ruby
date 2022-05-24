# frozen_string_literal: true

require "bundler/setup"
require "bundler/audit/task"
require "rspec/core/rake_task"
require "rubocop/rake_task"

Bundler::Audit::Task.new
RSpec::Core::RakeTask.new :spec
RuboCop::RakeTask.new

desc "Run code quality checks"
task code_quality: %i[bundle:audit rubocop]

task default: %i[code_quality spec]
