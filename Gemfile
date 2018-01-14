# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.4.2'

gem 'bcrypt', '~> 3.1.11'
gem 'figaro', '~> 1.1.1'
gem 'pg', '~> 0.21.0'
gem 'puma', '~> 3.11.0'
gem 'rack-cors', '~> 1.0.2'
gem 'rails', '~> 5.1.4'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 4.8.2'
  gem 'faker', '~> 1.8.7'
  gem 'rspec-rails', '~> 3.7.2'
  gem 'rspec_junit_formatter'
  gem 'rubocop', '~> 0.52.1', require: false
  gem 'rubocop-rspec', '~> 1.21.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'json_matchers', '~> 0.7.2'
  gem 'shoulda-matchers', '~> 3.1.2'
  gem 'simplecov', '~> 0.15.1', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
