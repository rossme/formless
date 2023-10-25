# frozen_string_literal: true

require 'rails_helper'
require 'support/devise'

RSpec.describe Octokit, type: :model do
  describe 'configuration' do
    it 'should have a login' do
      expect(Octokit.login).to eq(ENV['GITHUB_USERNAME'])
    end

    it 'should have an access token' do
      expect(Octokit.access_token).to eq(ENV['GITHUB_PERSONAL_ACCESS_TOKEN'])
    end
  end
end
