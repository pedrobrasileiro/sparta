require 'factory_girl'

FactoryGirl.define do
  factory :user do
    email                 { Faker::Internet::free_email }
    password              '123456'
    password_confirmation '123456'
  end
end
