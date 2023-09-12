require 'rails_helper'

RSpec.describe User, type: :model do
  context 'registered as a user' do
    let(:user) { build(:user) }

    it 'signs them up as a new user' do
      expect(user).to be_valid
      expect(user.email).to eq(user.email)
    end

    it 'has many clients' do
      expect(user.clients).to be_a(ActiveRecord::Associations::CollectionProxy)
    end

    it 'has many prompts' do
      expect(user.prompts).to be_a(ActiveRecord::Associations::CollectionProxy)
    end
  end

  context 'when user is persisted' do
    let(:user) { build(:user) }

    before do
      user.save!
    end

    it 'once persisted it can create new clients' do
      new_client = user.clients.create!(first_name: 'John', last_name: 'Doe')
      expect(user.reload.clients.last).to eq(new_client)
      expect(user.clients.count).to eq(1)
    end

    it 'once persisted it can create new prompts' do
      new_prompt = user.prompts.create!(input: 'How many clients do I have?')
      expect(user.reload.prompts.last).to eq(new_prompt)
      expect(user.prompts.count).to eq(1)
    end
  end
end
