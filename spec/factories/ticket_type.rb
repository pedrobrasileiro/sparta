require 'factory_girl'

FactoryGirl.define do
  factory :ticket_type do
    name    'Report'
    color   'purple'
    project Factory(:project)
  end
end