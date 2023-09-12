# spec/factories.rb

# Define global sequences here
FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
end
