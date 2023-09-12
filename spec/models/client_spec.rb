# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:client) { build(:client) }

  it 'is valid with valid attributes' do
    expect(client).to be_valid
  end

  it 'is not valid without a user' do
    client.user = nil
    expect(client).to_not be_valid
  end

  it 'belongs to a user' do
    expect(client.user).to be_a(User)
  end

  it 'has many prompts' do
    expect(client.prompts).to be_a(ActiveRecord::Associations::CollectionProxy)
  end

  it 'has many prompts as actionable objects (polymorphic)' do
    client.prompts << build(:prompt)
    expect(client.prompts.first.actionable).to eq(client)
  end
end
