ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|

  # config.before(:each) do
  #   load "#{Rails.root}/db/seeds.rb"
  # end
  config.include Devise::TestHelpers, :type => :controller
  config.use_transactional_fixtures = false
  config.include CapybaraHelpers
  config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

end