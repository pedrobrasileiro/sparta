require 'factory_girl'

FactoryGirl.define do
  factory :ticket do
    description 'Ticket description'
    project Factory(:project)
  end
end