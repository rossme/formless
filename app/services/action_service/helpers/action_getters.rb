# frozen_string_literal: true

module ActionService
  module Helpers
    module ActionGetters

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
    end
  end
end
