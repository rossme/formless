# frozen_string_literal: true

module ActionService

  class ActionCreator
    include Helpers::ActionHelper
    include Helpers::ActionGetters
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
      update_prompt(false)
      raise e
    end

    private

    def fetch_prompt
      @prompt = Prompt.find(persisted_prompt_id)
    end

    def create_prompt_action
      raise ActionError, I18n.t('action_service.error.action_type') unless action_type

      @prompt_action = send(action_type)
    rescue NoMethodError
      raise ActionError, I18n.t('action_service.error.no_method_error')
    end

    def update_prompt(actioned: true)
      prompt.update(
        actionable: actionable,
        action: prompt_action,
        actioned: actioned
      )
    end

    def user
      prompt.user
    end

    def clients
      @clients ||= user.clients
      return @clients if @clients.present?

      raise ActionError, I18n.t('action_service.error.no_clients')
    end

    def prompt_message
      @prompt_message ||= prompt.message_content
    end
  end
end
