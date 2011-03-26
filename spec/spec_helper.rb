require "rubygems"
require "bundler/setup"
require "nokogiri"
require 'fakeweb'
require 'simplecov'
SimpleCov.start

$LOAD_PATH << File.expand_path("../lib", __FILE__)
require 'gdoclet'
require 'sinatra/gdoclet_helper'

RSpec.configure do |config|

end
