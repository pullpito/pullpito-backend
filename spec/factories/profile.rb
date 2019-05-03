require 'faker'

FactoryBot.define do
    factory :profile do
        sequence(:id) { |n| n }
        first_name { Faker::Name.first_name }
        last_name { Faker::Name.last_name }
    end
end