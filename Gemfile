source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.5'

gem 'sinatra', '~> 2.1'
gem 'mysql2', '~> 0.5'

group :development, :test do
  gem 'pry', '~> 0.13'
end

group :test do
  gem 'rspec', '~> 3.8'
  gem 'simplecov', '~> 0.19'
  gem 'simplecov-console', '~> 0.7'
  gem 'database_cleaner-sequel', '~> 1.8'
end
