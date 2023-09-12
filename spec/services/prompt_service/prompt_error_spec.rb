# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PromptService::PromptError do
  describe 'PromptError' do
    it 'is a StandardError' do
      expect(described_class).to be < StandardError
    end
  end
end
