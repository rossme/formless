# spec/factories/advisors.rb

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { :password_digest }
    created_at { DateTime.now }
  end
end
