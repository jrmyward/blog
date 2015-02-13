source 'https://rubygems.org'

gem 'rails', '4.2.0'

gem 'responders', '~> 2.0'

# assets
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby
gem 'less-rails'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

# authentication
gem 'devise', '~> 3.4'

# blog
gem 'acts-as-taggable-on'
gem 'ancestry'
gem 'friendly_id'
gem 'pygments.rb'
gem 'rakismet'
gem 'redcarpet'
gem 'will_paginate'
gem 'will_paginate-bootstrap'

# caching
gem 'dalli'

# cron
gem 'whenever', '~> 0.8', :require => false

# database
gem 'pg'
gem 'sanitize'

# deployment
gem 'unicorn'

# image manipulation
gem 'mini_magick'
gem 'carrierwave', git: 'git@github.com:carrierwaveuploader/carrierwave.git', branch: 'master'

# javascript
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.

# mailchimp
gem 'gibbon'

# querying
gem 'pg_search'

# queque
gem 'sidekiq'

# sitemap
gem 'sitemap_generator'

# themes
gem 'ocd_theme_magnus', git: 'git@github.com:oc-digital/ocd_theme_magnus.git'
gem 'ocd_theme_admin_genius', git: 'git@github.com:oc-digital/ocd_theme_admin_genius.git', tag: 'v2.0.3'

# views
gem 'browser'
gem "font-awesome-rails", '~> 3.2.1.3'
gem 'draper', '~> 1.3'
gem 'haml'
gem 'haml-rails'
gem 'simple_form'

group :doc do
  # gem 'sdoc', require: false
  gem 'yard'
end

# Tools
gem 'pry-rails'

group :development do
  gem 'bullet'
  gem 'capistrano', '3.2.1'
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-sidekiq', '0.3.6', require: false
  gem 'letter_opener'
end

group :development, :test do
  gem 'byebug'
  gem 'launchy'
  gem 'rack-mini-profiler', require: false
  gem 'rspec', '~> 3.0'
  gem 'rspec-rails'
  gem 'guard-rspec', '4.2.7'
  gem 'guard-livereload'
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'childprocess'
  gem 'pry-byebug'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'fuubar'
  gem 'poltergeist'
  gem 'puffing-billy', git: "https://github.com/oesmith/puffing-billy"
  gem 'rspec-sidekiq'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', '>=0.4.2', :require => false
  gem 'timecop'
  gem 'turn', :require => false
  gem 'vcr'
  gem 'webmock'
end
