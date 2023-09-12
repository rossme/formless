# frozen_string_literal: true

module ActionService

  # PoC user request variables
  ACTION_VARIABLES = %w[
    GET_CLIENT_COUNT
    GET_LAST_CLIENT
    GET_LAST_CLIENT_NAME
    GET_ALL_CLIENTS
    GET_FIRST_CLIENT
    GET_CLIENT_PHONE_NUMBERS
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
      update_prompt
      raise e
    end

    private

    def fetch_prompt
      @prompt = Prompt.find(persisted_prompt_id)
    end

    def create_prompt_action
      raise ActionError, I18n.t('action_service.error.action_type') unless action_type

      @prompt_action = send(action_type)
      @actioned = true
    rescue NoMethodError
      raise ActionError, I18n.t('action_service.error.no_method_error')
    end

    def update_prompt
      prompt.update(
        actionable: actionable,
        action: prompt_action,
        actioned: @actioned || false
      )
    end

    def get_client_count
      count = clients.count.presence || 0
      prompt_message.gsub('[GET_CLIENT_COUNT]', count.to_s)
    end

    def get_first_client
      client = clients.first
      prompt_message.gsub('[GET_FIRST_CLIENT]', client.inspect)
    end

    def get_last_client
      client = clients.last
      prompt_message.gsub('[GET_LAST_CLIENT]', client.inspect)
    end

    def get_last_client_name
      client = clients.last
      prompt_message.gsub('[GET_LAST_CLIENT_NAME]', "#{client.first_name} #{client.last_name}, id: #{client.id}")
    end

    def get_all_clients
      client_names = clients.map { |c| "#{c.first_name} #{c.last_name}, id: #{c.id}" }
      prompt_message.gsub('[GET_ALL_CLIENTS]', client_names.join('. '))
    end

    def get_client_phone_numbers
      client_phone_numbers = clients.map { |c| c.phone_number.to_s.presence }
      prompt_message.gsub('[GET_CLIENT_PHONE_NUMBERS]', client_phone_numbers.join(', '))
    end

    def create_client
      params = prompt_message.merge(user: user)
      @actionable = Client.new(params)
      I18n.t('action_service.success.create_client')
    end

    def user
      prompt.user
    end

    def clients
      @clients ||= user.clients
      return @clients if @clients.present?

      raise ActionError, I18n.t('action_service.error.no_clients')
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
