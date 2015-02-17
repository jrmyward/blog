require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  unless ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails' do
      add_group 'Controllers', 'app/controllers'
      add_group 'Models', 'app/models'
      add_group 'Helpers', 'app/helpers'
      add_group 'Forms', 'app/forms'
      add_group 'Libraries', 'lib'
      # add_group "Long files" do |src_file|
      #   src_file.lines.count > 100
      # end
      add_group 'Services', 'app/services'
      add_group 'Uploads', 'app/uploaders'
    end
  end

  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require 'spec_helper'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'billy/rspec'
  require 'capybara/rspec'
  require 'capybara/rails'
  require 'capybara/poltergeist'
  require 'database_cleaner'
  # require 'mandrill_mailer/offline'
  require 'sidekiq/testing'
  require 'shoulda-matchers'
  require 'webmock/rspec'

  # Capybara.javascript_driver = :selenium
  # Capybara.javascript_driver = :poltergeist
  Capybara.javascript_driver = :poltergeist_billy

  Billy.configure do |c|
    c.cache = true
    c.cache_request_headers = false
    c.ignore_params = [
      "http://fonts.googleapis.com/css?family=Droid+Serif",
      "http://fonts.googleapis.com/css?family=Droid+Sans:400,700",
      "http://fonts.googleapis.com/css?family=Boogaloo",
      "http://fonts.googleapis.com/css?family=Economica:700,400italic"
    ]
    c.path_blacklist = []
    c.persist_cache = true
    c.ignore_cache_port = true # defaults to true
    c.non_successful_cache_disabled = false
    c.non_successful_error_level = :warn
    c.non_whitelisted_requests_disabled = false
    c.cache_path = 'spec/vcr/puffingbilly'
    # Stripe uses jsonp, which changes its callback param based on the current time
    # That means we'd never hit the cache, so this makes it ignore the param that changes
    c.dynamic_jsonp = true
    c.dynamic_jsonp_keys = ["callback"]
  end

  require 'draper/test/rspec_integration'
  # Draper::ViewContext.test_strategy :fast

  # Requires supporting ruby files with custom matchers and macros, etc, in
  # spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
  # run as spec files by default. This means that files in spec/support that end
  # in _spec.rb will both be required and run as specs, causing the specs to be
  # run twice. It is recommended that you do not name files matching this glob to
  # end with _spec.rb. You can configure this pattern with with the --pattern
  # option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  # Checks for pending migrations before tests are run.
  # If you are not using ActiveRecord, you can remove this line.
  ActiveRecord::Migration.maintain_test_schema!

  RSpec.configure do |config|

    # Include / Extend
    config.include ActiveJob::TestHelper
    config.include Devise::TestHelpers, :type => :controller
    # config.extend ControllerMacros, :type => :controller
    config.include FactoryGirl::Syntax::Methods
    config.include MailerMacros

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = false

    # config.around(:each, type: :feature) do |example|
    #   WebMock.allow_net_connect!
    #   VCR.turned_off { example.run }
    #   WebMock.disable_net_connect!
    # end

    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation, {
        # %w[awards equipment exercise_body_areas exercise_categories exercise_types exercises exercise_equipments muscle_groups stats stat_units units]
        :except => %w[]
      }
      Timecop.return
    end

    config.before(:each) do
      DatabaseCleaner.start
      reset_email
      Sidekiq::Worker.clear_all
      # MandrillMailer.deliveries.clear
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

  end

end

Spork.each_run do
  # This code will be run each time you run your specs.
  if ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails' do
      add_group 'Controllers', 'app/controllers'
      add_group 'Models', 'app/models'
      add_group 'Helpers', 'app/helpers'
      add_group 'Forms', 'app/forms'
      add_group 'Libraries', 'lib'
      add_group "Long files" do |src_file|
        src_file.lines.count > 100
      end
      add_group 'Services', 'app/services'
      add_group 'Uploads', 'app/uploaders'
    end
  end
end
