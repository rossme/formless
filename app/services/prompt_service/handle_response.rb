require 'openai'

module PromptService
  class HandleResponse
    include ActiveModel::Validations
    validates :user, :prompt, :ai_response, presence: true

    def initialize(user:, prompt:, ai_response:)
      @user        = user
      @prompt      = prompt
      @ai_response = ai_response
    end

    attr_reader :user, :prompt, :ai_response, :created_prompt

    def call
      ActiveRecord::Base.transaction do
        create_prompt_transaction
        # take_action(s)
      end
      self
    end

    private

    def create_prompt_transaction
      @created_prompt = Prompt.new(user: user, input: prompt, output: ai_response)
      created_prompt.save
    end

    def hash_response
      {
        created_prompt: created_prompt,
        message: parsed_message
      }
    end

    def parsed_message
      @parsed_message ||= message_content.include?('=>') ? JSON.parse(message_content.gsub!('=>', ': ')) : message_content
    end

    def message_content
      @message_content ||= ai_response.dig("choices", 0, "message", "content")
    end

    def take_action
      # do take_action stuff...
    end
  end
end
