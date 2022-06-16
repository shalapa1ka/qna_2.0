# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'
gem 'active_model_serializers', '~> 0.10.13'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'carrierwave'
gem 'cocoon'
gem 'devise'
gem 'doorkeeper'
gem 'jbuilder', '~> 2.7'
gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'pagy'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'pundit'
gem 'rails', '~> 6.1.6'
gem 'responders'
gem 'sass-rails', '>= 6'
gem 'slim'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'
gem 'responders'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rubocop'
end

group :development do
  gem 'letter_opener'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'shoulda-matchers'
  gem 'webdrivers'
  gem 'json_spec', '~> 1.1', '>= 1.1.5'
  gem 'database_cleaner-active_record'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
