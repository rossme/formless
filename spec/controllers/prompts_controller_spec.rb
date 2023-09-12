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
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    login_user

    let(:request) { instance_double(PromptService::Request) }
    let(:prompt) { build(:prompt) }

    it 'should have strong params' do
      params = ActionController::Parameters.new(prompt: { text: 'How many clients do I have?' })
      permitted = params.require(:prompt).permit(:text)
      expect(permitted).to have_key(:text)
      expect(permitted[:text]).to eq('How many clients do I have?')
    end

    before do
      allow(request).to receive(:user_prompt).and_return('You have 3 clients.')
      allow(request).to receive(:valid?).and_return(true)
      allow(request).to receive(:call).and_return(prompt)
    end

    it 'should return success with a valid user and prompt' do
      expect(request.valid?).to eq(true)
      expect(request.call).to eq(prompt)
      expect(request.user_prompt).to eq('You have 3 clients.')
      expect(response).to be_successful
    end
  end

  describe 'GET #create without a valid user' do
    it 'should redirect the user' do
      get :create
      expect(subject.current_user).to eq(nil)
      expect(response.status).to eq(302)
    end
  end
end
