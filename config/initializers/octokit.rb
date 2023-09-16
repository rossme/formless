# frozen_string_literal: true

Octokit.configure do |c|
  c.login = ENV['GITHUB_USERNAME']
  # Change to ENV['GITHUB_ACCESS_TOKEN'] if using access token instead of password
  c.password = ENV['GITHUB_PASSWORD'] # or access_token
end
