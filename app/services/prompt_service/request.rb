require 'openai'

module PromptService
  class Request < Base

    def initialize(user:, prompt:)
      super
    end

    attr_reader :response

    def call
      validate_token_count
      generate_response
      handle_response
    end

    private

    def generate_response
      @response = client.chat(parameters: parameters)
    end

    def validate_token_count
      count = OpenAI.rough_token_count
      raise I18n.t 'prompt_service.error.token_count' if count > 100
    end
  end
end
