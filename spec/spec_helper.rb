require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, 'test')
require 'sequel'

SimpleCov.start

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  db_host = ENV['DATABASE_HOST']
  db_port = ENV['DATABASE_PORT']
  db_name = ENV['DATABASE_NAME']
  db_username = ENV['DATABASE_USERNAME']
  db_password = ENV['DATABASE_PASSWORD']
  uri = "mysql2://#{db_username}:#{db_password}@#{db_host}:#{db_port}/#{db_name}"
  DatabaseCleaner[:sequel].db = Sequel.connect(uri)
  DatabaseCleaner[:sequel].strategy = :truncation

  config.before(:all) do
    DatabaseCleaner[:sequel].start
    DatabaseCleaner[:sequel].clean
  end

  config.before(:each) do
    DatabaseCleaner[:sequel].start
  end

  config.after(:each) do
    DatabaseCleaner[:sequel].clean
  end
end
