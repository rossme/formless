# frozen_string_literal: true

require 'openai'

module PromptService
  class HandleResponse
    include ActiveModel::Validations
    validates :user, :user_prompt, :ai_response, presence: true

    def initialize(user:, user_prompt:, ai_response:)
      @user        = user
      @user_prompt = user_prompt
      @ai_response = ai_response
    end

    attr_reader :user, :user_prompt, :ai_response, :persisted_prompt

    def call
      ActiveRecord::Base.transaction do
        persist_prompt_transaction
      end
      Rails.logger.info "Prompt created: #{persisted_prompt.inspect}"
      persisted_prompt
    rescue PromptError, ActiveRecord::RecordInvalid => e
      raise e
    end

    private

    def persist_prompt_transaction
      @persisted_prompt = Prompt.new(
        user: user,
        input: user_prompt,
        output: handle_output
      )
      persisted_prompt.save
    end

    def handle_output
      parsed_content || ai_response
    end

    def parsed_content
      ai_response['choices'][0]['message']['content'] = JSON.parse(message_content)
      ai_response
    rescue JSON::ParserError
      false
    end

    def message_errors
      # ai_response&.dig('error', 'message')
    end

    def message_content
      @message_content ||= ai_response.dig('choices', 0, 'message', 'content').strip
    end
  end
end
