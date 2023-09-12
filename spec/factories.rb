# spec/factories.rb

# Define global sequences here
FactoryBot.define do
  sequence :password_digest do |n|
    "password#{n}"
  end
end
