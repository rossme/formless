# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenAiRateLimitable do
  let(:user) { create(:user) }

  it 'extends ActiveSupport::Concern' do
    expect(described_class).to be_a(ActiveSupport::Concern)
  end

  describe '#exceeds_api_rate_limit?' do
    context 'when the user has made no prompts' do
      it 'returns false' do
        expect(user.exceeds_api_rate_limit?).to eq(false)
      end
    end

    context 'when the user has made prompts - 1 prompt includes 1 API request' do
      let(:prompts_count) { 1 }
      it 'returns false when they have not exceeded 60 requests in 1 hour' do
        create_list(:prompt, 1, user: user)
        prompts_in_last_hour = user.prompts.where('created_at >= ?', 1.hour.ago).count
        expect(prompts_in_last_hour).to eq(prompts_count)
        expect(user.exceeds_api_rate_limit?).to be_falsey
      end

      prompts_count = 61
      it 'returns true when they have exceeded 60 requests in 1 hour' do
        create_list(:prompt, 61, user: user)
        prompts_in_last_hour = user.prompts.where('created_at >= ?', 1.hour.ago).count
        expect(prompts_in_last_hour).to eq(prompts_count)
        expect(user.exceeds_api_rate_limit?).to be_truthy
      end
    end
  end
end
