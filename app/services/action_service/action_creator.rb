# frozen_string_literal: true

module ActionService

  ACTION_VARIABLES = %w[
    GET_CLIENT_COUNT
    GET_LAST_CLIENT_NAME
    GET_ALL_CLIENTS
  ].freeze

  class ActionCreator
    include ActiveModel::Validations
    validates :prompt_id, presence: true

    def initialize(persisted_prompt_id:)
      @persisted_prompt_id = persisted_prompt_id
    end

    attr_reader :persisted_prompt_id, :prompt, :action_type, :prompt_action, :actionable

    def call
      ActiveRecord::Base.transaction do
        fetch_prompt
        fetch_action_type
        create_prompt_action
        update_prompt
      end
    rescue ActionError => e
      raise e
    end

    private

    def fetch_prompt
      @prompt = Prompt.find(persisted_prompt_id)
    end

    def create_prompt_action
      @prompt_action = send(action_type)
    rescue NoMethodError
      raise ActionError, I18n.t('action_service.error.no_method_error')
    end

    def update_prompt
      prompt.update(
        actionable: actionable,
        action: prompt_action,
        actioned: true
      )
    end

    def get_client_count
      count = prompt.user.clients&.count.presence || 0
      prompt_message.gsub('[GET_CLIENT_COUNT]', count.to_s)
    end

    def get_last_client_name
      client = prompt.user.clients.last
      prompt_message.gsub('[GET_LAST_CLIENT_NAME]', "#{client.first_name} #{client.last_name}, id: #{client.id}")
    end

    def get_all_clients
      clients = prompt.user.clients
      client_names = clients.map { |c| "#{c.first_name} #{c.last_name}, id: #{c.id}" }
      prompt_message.gsub('[GET_ALL_CLIENTS]', client_names.join('. '))
    end

    def create_client
      params = prompt_message.merge(user: user)
      @actionable = Client.new(params)
      I18n.t('action_service.success.create_client')
    end

    def user
      prompt.user
    end

    def fetch_action_type
      if prompt_message.is_a?(Hash)
        @action_type = 'create_client'
      else
        fetch_type
      end

      raise ActionError, I18n.t('action_service.error.variable_error') unless @action_type
    end

    def fetch_type
      ACTION_VARIABLES.each do |v|
        if prompt_message.include?(v)
          @action_type = v.downcase
          break
        end
      end
    end

    def prompt_message
      @prompt_message ||= prompt.message_content
    end
  end
end
