# frozen_string_literal: true

source "https://rubygems.org"

gemspec

group :code_quality do
  gem "bundler-audit", "~> 0.7"
  gem "rubocop", "~> 1.14"
  gem "rubocop-performance", "~> 1.8"
  gem "rubocop-rake", "~> 0.5"
  gem "rubocop-rspec", "~> 2.0"
  gem "simplecov", "~> 0.20"
end

group :development do
  gem 'combustion', '~> 1.3'
  gem "rake", "~> 13.0"
end

group :test do
  gem "dotenv"
  gem "pg"
  gem "rspec", "~> 3.9"
  gem "rspec-rails"
end

group :tools do
  gem "pry", "~> 0.13"
  gem "pry-byebug", "~> 3.9"
end
