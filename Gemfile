source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "git://github.com/#{repo_name}"
end

gem 'rails', '~> 6.1'
gem 'bootsnap', require: false
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'sprockets', '~> 4.0'
gem 'font_awesome5_rails'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
gem 'mysql2'
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 5.0'
gem 'jbuilder', '~> 2.0'
gem 'lazyload-rails'
gem 'bower-rails'
gem "active_model_serializers"
gem 'dalli'
gem 'figaro'
gem 'simple_form', ">= 5.0.0"
gem 'chosen-rails'
gem 'RedCloth'
gem 'tinymce-rails', github: 'spohlenz/tinymce-rails.git'
gem 'foundation-rails', '~> 5.5' # After this, getting incompatible units errors
gem 'friendly_id', '>= 5.2'
gem 'paperclip'
gem 'paperclip-compression'
gem 'fog-core', '< 2.1.1' # fog-rackspace isn't working with fog-core after 2.1.0
gem 'fog-rackspace'
gem 'acts_as_list'
gem 'acts_as_tree'
gem 'acts-as-taggable-on'
gem 'devise'
gem 'activeadmin'
gem 'inherited_resources'
gem 'activeadmin-sortable'
gem 'pundit'
gem 'delayed_job_active_record'
gem 'daemons'
gem 'httparty'
gem 'rails_autolink'
gem 'goacoustic'
gem 'oauth2'
gem 'ransack' # using for service center search
gem 'exception_notification'
gem 'mailgun_rails' # mailer service from Rackspace
gem 'recaptcha', require: "recaptcha/rails"
gem 'nokogiri' # for parsing HTML to generate subnavs on EMEA portal
gem 'thinking-sphinx', '~> 4.0.0'
gem 'kaminari'
gem 'globalize'
gem 'friendly_id-globalize'
gem 'http_accept_language'
gem 'rails-i18n'
gem 'maxminddb' # for geocoding ip addresses
gem 'geolite2_city' # db for maxminddb
gem 'email_validator'
gem 'country_select'
gem 'will_paginate'
gem 'will_paginate_infinite',
  git: 'https://github.com/adamtao/will_paginate_infinite.git',
  branch: "master"

group :development do
  gem 'bumbler'
  gem 'letter_opener'
  gem 'spring'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'

  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'sshkit'
  gem 'colorize'
  gem 'capistrano'
  gem 'capistrano3-delayed-job', '~> 1.0'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  # gem 'byebug',      '3.4.0'
  gem 'pry-byebug'
  gem 'rails-erd'
  gem 'awesome_print'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'jasmine-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'json-schema'
  gem 'faker'
  gem 'webdrivers'
  gem 'launchy'
end
