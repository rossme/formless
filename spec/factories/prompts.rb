# spec/factories/clients.rb

FactoryBot.define do
  factory(:prompt) do
    user { FactoryBot.create(:user) }
    input { Faker::Lorem.sentence }
  end
end
