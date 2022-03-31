source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'pg', '~> 1.2.2'
gem 'puma', '~> 4.3'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'draper'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', '~> 0.80.1'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  # Rspec is fetching directly from repo due to rails 6 compatibility bug : https://github.com/rails/rails/issues/35417
  gem 'rspec-rails', git: 'https://github.com/rspec/rspec-rails'
  gem 'rspec-core', git: 'https://github.com/rspec/rspec-core'
  gem 'rspec-mocks', git: 'https://github.com/rspec/rspec-mocks'
  gem 'rspec-support', git: 'https://github.com/rspec/rspec-support'
  gem 'rspec-expectations', git: 'https://github.com/rspec/rspec-expectations'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
