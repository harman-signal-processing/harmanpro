source 'https://rubygems.org'

gem 'rails', '4.1.8'
gem 'mysql2'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'bower-rails'
gem "active_model_serializers", "~> 0.8.0"
gem 'dalli'
gem 'figaro'
gem 'simple_form'
gem 'foundation-rails', '~> 5.4'
gem 'friendly_id'
gem 'paperclip'
gem 'aws-sdk'
gem 'acts_as_list'
gem 'acts_as_tree'
gem 'devise'
gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin'
gem 'activeadmin-sortable'

gem 'sdoc', '~> 0.4.0',          group: :doc

group :development do
  gem 'spring'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'

  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'sshkit', '~> 1.5.1' # version 1.6.0 caused problems deploying
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'ZenTest'
  gem 'simplecov', require: false
  gem 'rspec-autotest'
  gem 'json-schema'
  gem 'faker'
  gem 'launchy'
  gem 'selenium-webdriver'
end
