require 'rubygems'
require 'rspec'

ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require "rspec/rails"
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
Rails.backtrace_cleaner.remove_silencers!

RSpec.configure do |config|
  require 'rspec/expectations'
  config.include RSpec::Matchers
  config.color_enabled = true

  # == Mock Framework
  config.mock_with :rspec

  config.before :all do
    # global build-up. Useful if you have external things like Redis or other setup
  end

  config.after :all do
    # global tear-down
  end
end