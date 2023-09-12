require 'rails_helper'

RSpec.describe User, type: :model do
  context 'registered as a user' do
    let(:user) { build(:user) }

    it 'signs them up as a new user' do
      expect(user).to be_valid
      expect(user.email).to eq(user.email)
    end

    it 'once persisted it can create new clients' do
      user.save!
      new_client = user.clients.create!(first_name: 'John', last_name: 'Doe')
      expect(user.reload.clients.last).to eq(new_client)
      expect(user.clients.count).to eq(1)
    end
  end
end
