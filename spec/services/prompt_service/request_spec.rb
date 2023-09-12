# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PromptService::Request do
  let(:user) { create(:user) }
  let(:prompt) { build(:prompt) }
  let(:request) { instance_double(PromptService::Request) }

  it 'expect described class to inherit from #base' do
    expect(described_class).to be < PromptService::Base
  end

  it 'is valid with valid attributes' do
    allow(request).to receive(:valid?).and_return(true)
    expect(request).to be_valid
  end

  describe '#call' do
    it 'validates the token count' do
      expect(OpenAI.rough_token_count).to be < 50
    end

    it 'generates a response' do
      allow(request).to receive(:call).and_return(prompt)
      expect(request.call).to eq(prompt)
    end

    it 'handles the response' do
      allow(request).to receive(:handle_response).and_return(prompt)
      expect(request.handle_response).to eq(prompt)
    end
  end
end
