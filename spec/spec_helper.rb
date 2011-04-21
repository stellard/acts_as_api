$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__))

require "rails_app/config/environment"
require 'rspec/rails'
require 'ruby-debug'

require 'acts_as_api'

ENV["RAILS_ENV"] = "test"

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|file| require file }

load_schema = lambda {
  load "#{Rails.root.to_s}/db/schema.rb" # use db agnostic schema by default
  # ActiveRecord::Migrator.up('db/migrate') # use migrations
}
silence_stream(STDOUT, &load_schema)


RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end