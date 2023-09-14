# frozen_string_literal: true

module ActionService
  module Helpers
    module ActionHelper

      ACTION_VARIABLES = %w[
        GET_CLIENTS_COUNT
        GET_LAST_CLIENT
        GET_LAST_CLIENT_NAME
        GET_ALL_CLIENTS
        GET_FIRST_CLIENT
        GET_CLIENTS_PHONE_NUMBERS
      ].freeze

      def fetch_action_type
        if prompt_message.is_a?(Hash)
          @action_type = 'create_client'
        else
          fetch_type
        end
        raise ActionError, I18n.t('action_service.error.variable_error') unless @action_type
      end

      def fetch_type
        ACTION_VARIABLES.each do |var|
          if regex_match?(var)
            @action_type = var.downcase
            break
          end
        end
      end

      def regex_match?(var)
        prompt_message.match?(regex_pattern(var))
      end

      def regex_pattern(var)
        /\[#{Regexp.escape(var)}\]/
      end
    end
  end
end
