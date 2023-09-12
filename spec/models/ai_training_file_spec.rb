# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AiTrainingFile, type: :model do
  let(:ai_training_file) { build(:ai_training_file) }

  it 'is valid with valid attributes' do
    expect(ai_training_file).to be_valid
  end

  it 'is not valid without a user' do
    ai_training_file.ai_model = nil
    expect(ai_training_file).to_not be_valid
  end
end
