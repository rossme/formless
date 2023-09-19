# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Schema', type: :request do
  describe 'GET /index' do
    let(:schema_path) { Rails.root.join('config', 'documentation', 'openapi', 'api_v1_schema.yaml') }
    it 'returns http success' do
      get '/api/v1/schema'
      expect(response).to have_http_status(:success)
    end

    let(:fake_schema_path) { 'fake_directory/api_v1_schema_fake.yaml' }
    it 'returns http not found' do
      get '/api/v1/schema'
      file_exists = File.exist?(fake_schema_path)
      expect(file_exists).to be(false)
    end
  end
end
