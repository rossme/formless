# frozen_string_literal: true

require 'rails_helper'
require 'support/devise'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#octokit_request' do
    it 'should be a hash' do
      expect(helper.octokit_request).to be_a(Hash)
    end

    it 'should have a latest_release key' do
      expect(helper.octokit_request).to have_key(:latest_release)
    end

    it 'should have a latest_deploy key' do
      expect(helper.octokit_request).to have_key(:latest_deploy)
    end

    it 'should have a latest_release value' do
      expect(helper.octokit_request[:latest_release]).to be_present
    end

    it 'should store the request in cache' do
      expect(Rails.cache).to receive(:fetch).with('octokit_request', expires_in: 12.hours)
      helper.octokit_request
    end

    it 'should raise an error if the latest release request fails' do
      allow(Octokit).to receive(:latest_release).and_raise(Octokit::Unauthorized)
    end

    it 'should raise an error if the deployments request fails' do
      allow(Octokit).to receive(:deployments).and_raise(Octokit::Unauthorized)
    end
  end
end
