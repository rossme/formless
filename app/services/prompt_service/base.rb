# frozen_string_literal: true

module PromptService
  class Base
    include ActiveModel::Validations
    validates :user, :user_prompt, presence: true

    TRAINING_FILE_ID = 1

    def initialize(user:, user_prompt:)
      @user = user
      @user_prompt = user_prompt
    end

    attr_reader :user, :user_prompt, :persisted_prompt

    def client
      OpenAI::Client.new
    end

    def parameters
      {
        model: fine_tune_model,
        messages: [
          { role: 'system', content: system_content },
          { role: 'user', content: user_prompt }
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
      AiTrainingFile.find(TRAINING_FILE_ID)
    end

    def fine_tune_model
      training_file_object.fine_tune_model
    end

    def handle_response
      @persisted_prompt = PromptService::HandleResponse.new(user: user, user_prompt: user_prompt, ai_response: response).call
    end
  end
end
