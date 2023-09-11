# spec/factories/clients.rb

FactoryBot.define do
  factory(:client) do
    id { 12 }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { :email } # using the sequence defined in spec/factories.rb
  end
end
