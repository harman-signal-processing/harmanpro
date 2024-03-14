source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}"
end

# Passenger is picky that the server's root versions of these match
gem 'strscan', '3.1.0'
gem "digest", "3.1.1"

gem 'rails', '~> 7.1' #, '>= 7.0.4'
gem 'bootsnap', require: false
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'sprockets', '~> 4.0'
gem 'sprockets-rails'
gem 'font_awesome5_rails'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
gem 'mysql2'
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 6.0'
gem 'jbuilder', '~> 2.0'
gem 'lazyload-rails'
gem 'bower-rails'
gem "active_model_serializers"
gem 'dalli'
gem 'figaro'
gem 'simple_form', ">= 5.0.0"
gem 'chosen-rails', github: "adamtao/chosen-rails" # non-coffeescript version
gem 'RedCloth'
gem 'tinymce-rails' #, '< 5.9'
gem 'foundation-rails', '~> 5.5' # After this, getting incompatible units errors
gem 'friendly_id', '>= 5.2'
gem 'kt-paperclip', '>= 7.0'
gem 'kt-paperclip-compression'
gem 'addressable'
gem 'aws-sdk-s3'
gem 'fog-core'
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
gem 'oauth2'
gem 'ransack' #, "< 4.0.0" # v4 requires whitelisting params
gem 'exception_notification'
gem 'recaptcha', require: "recaptcha/rails"
gem 'nokogiri', '>= 1.13.4' # for parsing HTML to generate subnavs on EMEA portal
gem 'thinking-sphinx'
gem 'kaminari'
gem 'globalize'
gem 'friendly_id-globalize', github: 'norman/friendly_id-globalize'
gem 'http_accept_language'
gem 'rails-i18n'
gem 'maxminddb' # for geocoding ip addresses
gem 'geolite2_city' # db for maxminddb
gem 'email_validator'
gem 'country_select', '~> 8.0' # 9.0 broke country dropdowns in activeadmin
gem 'will_paginate'
gem 'will_paginate_infinite',
  git: 'https://github.com/adamtao/will_paginate_infinite.git',
  branch: "master"

# rack middleware security gems:
gem 'rack-attack'
gem 'rack-utf8_sanitizer'

group :development do
  gem 'webrick'
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
  gem 'marginalia'
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
