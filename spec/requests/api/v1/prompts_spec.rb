# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Prompts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/api/v1/prompts'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      prompt = create(:prompt)
      get "/api/v1/prompts/#{prompt.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
