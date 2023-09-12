# spec/factories/clients.rb

FactoryBot.define do
  factory(:prompt) do
    user { FactoryBot.create(:user) }
    input { 'How many clients to I have?' }
  end
end
