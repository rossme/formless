
module PromptService
  class Base
    include ActiveModel::Validations
    validates :user, :prompt, presence: true

    def initialize(user:, prompt:)
      @user = user
      @prompt = prompt
    end

    attr_reader :user, :prompt

    def client
      OpenAI::Client.new
    end

    def parameters
      {
        model: fine_tune_model,
        messages: [{ role: 'user', content: prompt }],
        temperature: 0.7
      }
    end

    def fine_tune_model
      ENV['OPENAI_FINE_MODEL']
    end

    def handle_response
      PromptService::HandleResponse.new(user: user, prompt: prompt, ai_response: response).call
    end
  end
end
