# frozen_string_literal: true

# Using Middleware::OpenAiRateLimiter to limit the number of requests a user can make to the OpenAI API.
module OpenAiRateLimitable
  extend ActiveSupport::Concern

  API_RATE_LIMIT = 60
  TIME_WINDOW = 1.hour

  def exceeds_api_rate_limit?
    return false if prompts.none?

    requests_in_window = prompts.where('created_at >= ?', TIME_WINDOW.ago).count
    requests_in_window > API_RATE_LIMIT
  end
end
