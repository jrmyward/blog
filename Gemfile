source 'https://rubygems.org'

gem 'rails', '4.1.0'

# assets
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby
gem 'less-rails'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

# authentication
gem 'devise'

# blog
gem 'acts-as-taggable-on', git: 'https://github.com/mbleigh/acts-as-taggable-on.git'
gem 'ancestry'
gem 'friendly_id', git: 'https://github.com/FriendlyId/friendly_id'
gem 'pygments.rb'
gem 'rakismet'
gem 'redcarpet'
gem 'will_paginate'
gem 'will_paginate-bootstrap'

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
# gem "squeel"

# queque
gem 'sidekiq'

# sitemap
gem 'sitemap_generator'

# themes
gem 'ocd_theme_magnus', git: 'git@github.com:oc-digital/ocd_theme_magnus.git'
gem 'ocd_theme_admin_genius', git: 'git@github.com:oc-digital/ocd_theme_admin_genius.git', tag: 'v2.0.1'

# views
gem 'browser', git: 'git://github.com/fnando/browser'
gem "font-awesome-rails", '~> 3.2.1.3'
gem 'haml'
gem 'haml-rails'
gem 'simple_form', git: 'git://github.com/plataformatec/simple_form.git', branch: 'v3.0'

group :doc do
  # gem 'sdoc', require: false
  gem 'yard'
end

# Tools


group :development do
  gem 'bullet'
  gem 'capistrano'
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-sidekiq' , github: 'seuros/capistrano-sidekiq', require: false
  # gem 'capistrano', '~> 3.1.0'
  # gem 'capistrano-rails',   '~> 1.1', require: false
  # gem 'capistrano-bundler', '~> 1.1', require: false
  # gem 'capistrano-rbenv', '~> 2.0', require: false
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :development, :test do
  gem 'launchy'
  gem 'rack-mini-profiler', require: false
  gem 'rspec', '~> 3.0.0.beta2'
  gem 'rspec-rails'
  gem 'guard-rspec', '4.2.7'
  gem 'guard-livereload'
  gem 'spork-rails', github: 'sporkrb/spork-rails' # rubygems version not rails 4 compatible
  gem 'guard-spork'
  gem 'childprocess'
  gem 'pry'
  gem 'pry-debugger'
end

group :test do
  gem 'capybara', git: 'git@github.com:jnicklas/capybara.git', branch: 'master'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'poltergeist'
  gem 'shoulda-matchers'
  gem 'simplecov', '>=0.4.2', :require => false
  gem 'stripe-ruby-mock', '>= 1.8.7.4'
  gem 'timecop'
  gem 'turn', :require => false
  gem 'vcr'
  gem 'webmock'
end
