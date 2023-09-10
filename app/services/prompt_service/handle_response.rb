# frozen_string_literal: true

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
      end
      self
    end

    private

    def create_prompt_transaction
      # Update actioned after the ActionJob has run
      @created_prompt = Prompt.new(
        actionable: user,
        input: prompt,
        output: handle_output
      )
      created_prompt.save
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
