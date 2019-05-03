require 'faker'

FactoryBot.define do
    factory :user do
        sequence(:id) { |n| n }
        email { Faker::Internet.email }
        password { Faker::Internet.password }
    end
end