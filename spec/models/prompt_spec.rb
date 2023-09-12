require 'rails_helper'

RSpec.describe Prompt, type: :model do
  context 'validations' do
    let(:prompt) { build(:prompt) }

    it 'is valid with valid attributes' do
      expect(prompt).to be_valid
    end

    it 'is not valid without a text' do
      prompt.input = ''
      expect(prompt).to_not be_valid
    end

    it 'is not valid without a user' do
      prompt.user = nil
      expect(prompt).to_not be_valid
    end

    it 'it has message_content' do
      prompt.output = { 'choices' => [{ 'message' => { 'content' => 'You have 3 clients.' } }] }
      expect(prompt.message_content).to eq('You have 3 clients.')
    end

    it 'belongs to a user' do
      expect(prompt.user).to be_a(User)
    end

    it 'belongs to actionable objects (polymorphic)' do
      prompt.actionable = build(:client)
      expect(prompt.actionable).to be_a(Client)
    end
  end
end
