# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.6.3'

gem 'active_model_serializers', '~> 0.10.10'
gem 'bcrypt', '~> 3.1.13'
gem 'figaro', '~> 1.1.1'
gem 'kaminari', '~> 1.1.1'
gem 'knock', '~> 2.1.1'
gem 'pg', '~> 1.2.3'
gem 'puma', '~> 4.3.3'
gem 'rack-cors', '~> 1.1.1'
gem 'rails', '~> 5.2.4.2'
gem 'rails-i18n', '~> 5.1.3'
gem 'timber', '~> 3.0.1'

group :development, :test do
  gem 'factory_bot_rails', '~> 5.1.1'
  gem 'faker', '~> 2.10.2'
  gem 'pry', '~> 0.12.2'
  gem 'rspec-rails', '~> 3.9.1'
  gem 'rubocop', '~> 0.80.1', require: false
  gem 'rubocop-rspec', '~> 1.38.1'
end

group :development do
  gem 'listen', '~> 3.2.1'
  gem 'spring', '~> 2.1.0'
  gem 'spring-watcher-listen', '~> 2.0.1'
end

group :test do
  gem 'json_matchers', '~> 0.11.1'
  gem 'shoulda-matchers', '~> 4.3.0'
  gem 'simplecov', '~> 0.18.5', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
