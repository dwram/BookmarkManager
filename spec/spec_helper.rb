require 'capybara/rspec'
require 'simplecov'
require 'simplecov-console'
require 'pg'
require_relative './features/web_helpers'
require_relative '../app'
require_relative './backend_helpers'
ENV['RACK_ENV'] = 'test'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
                                                                   SimpleCov::Formatter::Console,
                                                               # Want a nice code coverage website? Uncomment this next line!
                                                               # SimpleCov::Formatter::HTMLFormatter
                                                               ])
SimpleCov.start

# For accurate test coverage measurements, require your code AFTER 'SimpleCov.start'
Capybara.app = BookmarkManager

RSpec.configure do |config|

  config.before(:each) do
    truncation
  end

end