# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PromptService::Base do
  it 'is a Base class for PromptService::Request' do
    expect(described_class).to be > PromptService::Request
  end

  let(:user) { build(:user) }
  let(:params) { { user: user, user_prompt: 'How many clients do I have?' } }
  let(:subject) { described_class.new(params) }

  describe '#initialize' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid without valid attributes' do
      params[:user] = nil
      expect(subject).to_not be_valid
    end
  end

  describe '#client' do
    it 'returns a client' do
      expect(subject.client).to be_a(OpenAI::Client)
    end
  end

  describe '#parameters' do
    it 'returns a configuration hash' do
      allow(subject).to receive(:parameters).and_return({ model: 'String', messages: [] })
      expect(subject.parameters).to eq({ model: 'String', messages: [] })
    end
  end

  describe '#system_content' do
    it 'returns a string' do
      allow(subject).to receive(:system_content).and_return('String')
      expect(subject.system_content).to eq('String')
    end

    it 'raises an error if the content is blank' do
      allow(subject).to receive(:system_content).and_raise(I18n.t('prompt_service.error.system_content'))
      expect { subject.system_content }.to raise_error(I18n.t('prompt_service.error.system_content'))
    end
  end

  describe '#training_file_object' do
    let(:ai_training_file) { double(AiTrainingFile) }
    it 'returns an AiTrainingFile object' do
      allow(subject).to receive(:training_file_object).and_return(ai_training_file)
      expect(subject.training_file_object).to eq(ai_training_file)
    end
  end

  describe '#handle_response' do
    let(:prompt) { build(:prompt) }
    let(:handle_response) { instance_double(PromptService::HandleResponse) }

    it 'has valid attributes' do
      allow(handle_response).to receive(:valid?).and_return(true)
      expect(handle_response).to be_valid
    end

    it 'returns a persisted prompt' do
      allow(handle_response).to receive(:call).and_return(prompt)
      expect(handle_response.call).to eq(prompt)
    end
  end
end
