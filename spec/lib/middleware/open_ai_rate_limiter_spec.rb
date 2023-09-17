# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Middleware::OpenAiRateLimiter do
  describe '#call' do
    let(:app) { ->(env) { [200, env, 'app'] } }
    let(:middleware) { described_class.new(app) }
    let(:user) { create(:user) }

    # Double allows us to call methods on the object without having to create a real object
    let(:env) { { 'warden' => double(user: user) } }

    context 'when the user has not exceeded the API rate limit' do
      it 'calls the next middleware' do
        expect(app).to receive(:call).with(env)
        middleware.call(env)
      end
    end

    context 'when the user has exceeded the API rate limit' do
      before do
        allow(user).to receive(:exceeds_api_rate_limit?).and_return(true)
      end

      it 'returns a 429 error' do
        expect(middleware.call(env)).to eq([429, { 'Content-Type' => 'text/plain' },
                                            [I18n.t('middleware.rate_limit.error.exceeded')]])
      end
    end
  end
end
