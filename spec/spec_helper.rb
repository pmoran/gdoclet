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

def fake_get(url, body)
  url = URI.escape("https://docs.google.com#{url}")
  FakeWeb.register_uri(:get, url, :body => body)
end
