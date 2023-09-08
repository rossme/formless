# frozen_string_literal: true

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
        messages: [
          { role: 'system', content: system_content },
          { role: 'user', content: prompt }
        ],
        temperature: 0.7
      }
    end

    def system_content
      content = training_file_object.training_job.dig('messages', 'system')
      raise I18n.t 'prompt_service.error.system_content' if content.blank?

      content
    end

    def training_file_object
      AiTrainingFile.find(3)
    end

    def fine_tune_model
      training_file_object.fine_tune_model
    end

    def handle_response
      PromptService::HandleResponse.new(user: user, prompt: prompt, ai_response: response).call
    end
  end
end
