require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, ENV['APP_ENV'] || 'development')

require './app/models/food'

fs = Food.new('foo', 123).save
puts fs.all
