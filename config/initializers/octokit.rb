# frozen_string_literal: true

Octokit.configure do |c|
  c.login = ENV['GITHUB_USERNAME']
  c.access_token = ENV['GITHUB_PERSONAL_ACCESS_TOKEN']
end
