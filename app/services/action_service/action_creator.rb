# frozen_string_literal: true

module ActionService

  ACTION_VARIABLES = %w[
    GET_CLIENT_COUNT
    GET_LAST_CLIENT
    GET_ALL_CLIENTS
  ].freeze

  class ActionCreator
    include ActiveModel::Validations
    validates :prompt_id, presence: true

    def initialize(persisted_prompt_id:)
      @persisted_prompt_id = persisted_prompt_id
    end

    attr_reader :persisted_prompt_id, :prompt, :action_type, :prompt_action

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
    rescue ActiveRecord::RecordNotFound
      raise ActionError, I18n.t('action_service.error.prompt_not_found')
    end

    def create_prompt_action
      @prompt_action = send(action_type)
    rescue NoMethodError
      raise ActionError, I18n.t('action_service.error.no_method_error')
    end

    def update_prompt
      # Possibility to add polymorphic actionable association here, i.e., Client, if Client created
      prompt.update(
        action: prompt_action,
        actioned: true
      )
    end

    def get_client_count
      count = prompt.user.clients&.count.presence || 0
      "Let me help you with that... as of #{DateTime.now.strftime('%H:%M on %d-%m-%Y')}, you have #{count} client(s)."
    end

    def get_last_client
      client = prompt.user.clients.last
      "Your last client was #{client.first_name} #{client.last_name}."
    end

    def get_all_clients
      clients = prompt.user.clients
      client_names = clients.map { |c| "#{c.first_name} #{c.last_name}" }
      client_names.join(', ')
    end

    def fetch_action_type
      ACTION_VARIABLES.each do |v|
        if prompt_message.include?(v)
          @action_type = v.downcase
          break
        end
      end
      raise ActionError, I18n.t('action_service.error.variable_error') unless @action_type
    end

    def prompt_message
      @prompt_message ||= prompt.message_content
    end
  end
end
