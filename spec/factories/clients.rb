# spec/factories/clients.rb

FactoryBot.define do
  factory(:client) do
    user { FactoryBot.create(:user) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
  end
end
