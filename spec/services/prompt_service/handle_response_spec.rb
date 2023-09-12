# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PromptService::HandleResponse do
  let(:handle_response) { instance_double(PromptService::HandleResponse) }
  let(:prompt) { build(:prompt) }

  describe '#initialize' do
    it 'is valid with valid attributes' do
      allow(handle_response).to receive(:valid?).and_return(true)
      expect(handle_response).to be_valid
    end

    it 'is invalid without valid attributes' do
      allow(handle_response).to receive(:valid?).and_return(false)
      expect(handle_response).to_not be_valid
    end
  end

  describe '#call' do
    it 'returns a prompt' do
      allow(handle_response).to receive(:call).and_return(prompt)
      expect(handle_response.call).to eq(prompt)
    end

    # Perhaps overkill
    let(:logger) { spy('Rails::Logger') }
    it 'logs the response if successful' do
      logger.info("Prompt created: #{prompt.inspect}")
      expect(logger).to have_received(:info).with("Prompt created: #{prompt.inspect}")
    end

    it 'returns an error if rescued' do
      allow(handle_response).to receive(:call).and_return(PromptService::PromptError)
      expect(handle_response.call).to eq(PromptService::PromptError)
    end
  end
end
