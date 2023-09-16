# frozen_string_literal: true

module Middleware

  class OpenAiRateLimiter
    def initialize(app)
      @app = app
    end

    def call(env)
      if current_user(env)&.exceeds_api_rate_limit?
        return [429, { 'Content-Type' => 'text/plain' }, [I18n.t('middleware.rate_limit.error.exceeded')]]
      end

      @app.call(env)
    end

    def current_user(env)
      env['warden'].user(:user)
    end
  end
end
