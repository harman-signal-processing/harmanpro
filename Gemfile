source 'https://rubygems.org'

gem 'rails', '4.2.7.1'
gem 'responders', '~> 2.0'
gem 'mysql2' #, '~> 0.3.18'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'sprockets'
gem 'font-awesome-rails'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 5.0'
gem 'jbuilder', '~> 2.0'
gem 'bower-rails'
gem "active_model_serializers", "0.9.5" # 0.10+ is not backwards compatible
gem 'dalli'
gem 'figaro'
gem 'simple_form'
gem 'RedCloth'
gem 'tinymce-rails', git: 'https://github.com/spohlenz/tinymce-rails.git'
gem 'foundation-rails', '~> 5.5' # After this, getting incompatible units errors
gem 'friendly_id'
gem 'paperclip'
gem 'acts_as_list'
gem 'acts_as_tree'
gem 'acts-as-taggable-on', '~> 3.4'
gem 'devise'
gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin', ref: 'b20fd04e992f721f49557f4dc59c7da3a732ba68'
gem 'activeadmin-sortable'
gem 'pundit'
gem 'delayed_job_active_record'
gem 'daemons'
gem 'httparty'
gem 'rails_autolink'
gem 'cheetah_mail', "~> 0.6.0"
gem 'ransack' # using for service center search
gem 'exception_notification'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'ruby-pardot'
gem 'mailgun_rails' # mailer service from Rackspace

gem 'globalize', '~> 5.0.0'
gem 'friendly_id-globalize'
gem 'http_accept_language'
gem 'rails-i18n'

group :development do
  gem 'letter_opener'
#  gem 'web-console', '~> 3.0'
  gem 'spring'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'

  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'sshkit'
  gem 'colorize'
  gem 'capistrano3-delayed-job', '~> 1.0'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'jasmine-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'json-schema'
  gem 'faker'
  gem 'selenium-webdriver'
  gem 'launchy'
end
