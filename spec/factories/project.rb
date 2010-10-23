require 'factory_girl'
require "#{File.dirname(__FILE__)}/user.rb"

FactoryGirl.define do
  factory :project do
    name 'Sparta'
    user Factory(:user)
  end
end
