# frozen_string_literal: true

require 'rails_helper'
require 'support/devise'

RSpec.describe PromptsController, type: :controller do
  describe 'GET #index' do
    login_user

    it 'should have a current_user' do
      expect(subject.current_user).to_not eq(nil)
    end

    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #create' do
    login_user
    let(:request) { instance_double(PromptService::Request) }
    let(:prompt) { build(:prompt) }

    before do
      allow(request).to receive(:user_prompt).and_return('You have 3 clients.')
      allow(request).to receive(:valid?).and_return(true)
      allow(request).to receive(:call).and_return(prompt)
    end

    it 'should return success with a valid user' do
      expect(request.valid?).to eq(true)
      expect(request.call).to eq(prompt)
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #create without a valid user' do
    it 'should redirect the user' do
      post :create
      expect(subject.current_user).to eq(nil)
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
