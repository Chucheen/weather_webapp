require 'spec_helper'
ENV['RAILS_ENV'] = 'test'
require_relative '../config/environment.rb'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'