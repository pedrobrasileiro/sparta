require 'factory_girl'

FactoryGirl.define do
  factory :ticket_status do
    name    'Report'
    color   'purple'
    close   true
    project Factory(:project)
  end
end