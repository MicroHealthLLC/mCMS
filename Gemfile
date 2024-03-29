source 'https://rubygems.org'

# Load environment variables


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Improved inspect output for irb
gem 'hirb'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'better_errors'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'
  gem 'rubocop', '~> 0.48.1', require: false
  gem 'brakeman', :require => false
  gem 'rack-mini-profiler'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#for Tests
group :development, :test do
  gem 'awesome_print', require: 'ap'
  gem 'better_errors'
  gem 'letter_opener'
  gem 'binding_of_caller'
end

group :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'factory_girl_rails'
  gem 'faker'
end

gem 'devise'
gem 'devise-authy'
gem 'devise_security_extension', github: 'rubyroidlabs/devise_security_extension'
gem "omniauth-office365", github: 'jcarbo/omniauth-office365'
#omniauth authentification
gem "devise_ldap_authenticatable"
gem "omniauth-facebook"
gem "omniauth-github"
gem "omniauth-twitter"
gem "omniauth-google-oauth2"

gem 'therubyracer', platforms: :ruby
gem 'execjs'
gem 'carrierwave'
gem "jquery-fileupload-rails"
gem "mini_magick"
gem "cocoon"
gem 'simple_form'
gem "request_store"
gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem 'jquery-datatables-rails'
gem 'ajax-datatables-rails'
gem 'ckeditor_rails'
gem "recaptcha", require: "recaptcha/rails"
gem "paranoia", "~> 2.2.0.pre"
gem "figaro"
gem 'prawn-rails'
gem "survey", github: 'dierbro/survey'
gem 'roo'

# For exception detection
gem 'rollbar'

# WIKI IRNO
gem 'irwi', :git => 'git://github.com/alno/irwi.git'
gem 'bluecloth'

#FORUM SYS
gem 'thredded', '~> 0.8.2'
# Redis
gem 'redis', '~> 3.2'

#Notification
gem 'toastr-rails'

# postmark for emails
gem 'postmark-rails'

# breadcrumbs
gem "breadcrumbs_on_rails"

gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.43'

gem "jSignature", "~> 0.0.6"
gem 'faraday'
gem 'httparty'

gem 'exception_notification'

#installing adapter gems based on database.yml
require 'erb'
require 'yaml'
database_file = File.join(File.dirname(__FILE__), "config/database.yml")
if File.exist?(database_file)
  database_config = YAML::load(ERB.new(IO.read(database_file)).result)
  adapters = database_config.values.map {|c| c['adapter']}.compact.uniq
  if adapters.any?
    adapters.each do |adapter|
      case adapter
        when 'mysql2'
          gem "mysql2", "~> 0.3.11", :platforms => [:mri, :mingw, :x64_mingw]
          gem "activerecord-jdbcmysql-adapter", :platforms => :jruby
        when 'mysql'
          gem "activerecord-jdbcmysql-adapter", :platforms => :jruby
        when /postgresql/
          gem "pg", "~> 0.18.1", :platforms => [:mri, :mingw, :x64_mingw]
          gem "activerecord-jdbcpostgresql-adapter", :platforms => :jruby
        when /sqlite3/
          gem "sqlite3", :platforms => [:mri, :mingw, :x64_mingw]
          gem "jdbc-sqlite3", ">= 3.8.10.1", :platforms => :jruby
          gem "activerecord-jdbcsqlite3-adapter", :platforms => :jruby
        when /sqlserver/
          gem "tiny_tds", "~> 0.6.2", :platforms => [:mri, :mingw, :x64_mingw]
          gem "activerecord-sqlserver-adapter", :platforms => [:mri, :mingw, :x64_mingw]
        else
          warn("Unknown database adapter `#{adapter}` found in config/database.yml, use Gemfile.local to load your own database gems")
      end
    end
  else
    warn("No adapter found in config/database.yml, please configure it first")
  end
else
  warn("Please configure your config/database.yml first")
end

# Use textractor for parsing PDF and Word documents
gem 'textractor'

# Use Sunspot Rails and Sunspot Solr for our search engine
gem 'sunspot_rails'
gem 'sunspot_solr'
gem 'roo-xls'
gem 'pdf-forms'
gem "audited", "~> 4.4"
gem 'rails_email_validator'
gem "simple_calendar", "~> 2.0"
gem 'sidekiq'
gem 'twilio-ruby', '~> 4.11.1'
gem 'textris'



# Engines
gem 'links', path: 'engines/links'
# gem 'community_engine', path: 'engines/communityengine'
gem 'todo_list', path: 'engines/todo_list'
gem 'calculator', path: 'engines/calculator'
gem 'measurements_converter', path: 'engines/measurements_converter'
gem 'sticky_notes', path: 'engines/sticky_notes'
gem 'rordit', path: 'engines/rordit'
gem 'kanban', path: 'engines/kanban'
gem 'event_calendar', path: 'engines/event_calendar'
gem 'inventory', path: 'engines/inventory'
gem 'lms', path: 'engines/lms'
gem 'mindmap', path: 'engines/mindmap'
gem 'rss_feed', path: 'engines/rss_feed'
gem 'text_editor', path: 'engines/text_editor'
gem 'svg_edit', path: 'engines/svg_edit'
gem 'mhspreadsheet', path: 'engines/mhspreadsheet'
