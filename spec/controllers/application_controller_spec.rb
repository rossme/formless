# frozen_string_literal: true

require 'rails_helper'
require 'support/devise'
require 'pry'
RSpec.describe ApplicationController, type: :controller do

  describe '#sign_in_fake_user' do
    before do
      expect(described_class::FAKE_USER_ID).to eq(1)
    end

    let(:fake_user) { build(:user, id: described_class::FAKE_USER_ID) }

    it 'should find a fake user' do
      expect(fake_user.id).to eq(described_class::FAKE_USER_ID)
      expect(fake_user).to be_a(User)
      expect(fake_user).to be_valid
    end

    it 'should have a private method' do
      sign_in fake_user
      expect(subject.private_methods).to include(:sign_in_fake_user)
    end
  end
end
