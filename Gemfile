source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# assets
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

# authentication
gem 'devise', git: 'git://github.com/plataformatec/devise.git', branch: 'rails4'

# blog
gem 'friendly_id', git: 'https://github.com/FriendlyId/friendly_id'
gem 'redcarpet'
gem 'will_paginate'

# database
gem 'pg'
gem 'sanitize'

# deployment
gem 'capistrano', group: :development
gem 'unicorn'

# configuration
gem 'figaro'

# forms
gem 'simple_form', git: 'git://github.com/plataformatec/simple_form.git'

# javascript
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# json
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 1.2'

# views
gem 'browser', :git => 'git://github.com/fnando/browser'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  # gem 'sdoc', require: false
  gem 'yard'
end

gem 'hirb'

group :development do
  gem 'bullet'
  gem 'guard'
  gem 'guard-rspec'
end

group :test, :development do
  # gem 'spork-rails'
  gem 'rspec-rails', '~> 2.0'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'pry'
  gem 'rack-mini-profiler'
  gem 'rb-fsevent'
end

group :test do
  # gem 'guard-spork'
  gem 'shoulda-matchers'
  gem 'poltergeist'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'timecop'
  gem 'simplecov', '>=0.4.2', :require => false
  gem 'turn', :require => false
end