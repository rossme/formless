# frozen_string_literal: true

module ActionService
  module Helpers
    module ActionGetters

      def get_client_count
        prompt_message.gsub('[GET_CLIENT_COUNT]', (clients.count.presence || 0).to_s)
      end

      def get_first_client
        prompt_message.gsub('[GET_FIRST_CLIENT]', clients.first.inspect)
      end

      def get_last_client
        prompt_message.gsub('[GET_LAST_CLIENT]', last_client.inspect)
      end

      def get_last_client_name
        prompt_message.gsub('[GET_LAST_CLIENT_NAME]',
                            "#{last_client.first_name} #{last_client.last_name}, id: #{last_client.id}"
        )
      end

      def get_all_clients
        client_names = clients.map { |c| "#{c.first_name} #{c.last_name}, id: #{c.id}" }
        prompt_message.gsub('[GET_ALL_CLIENTS]', client_names.join('. '))
      end

      def get_client_phone_numbers
        client_phone_numbers = clients.map { |c| c.phone_number.to_s.presence }.compact
        prompt_message.gsub('[GET_CLIENT_PHONE_NUMBERS]', client_phone_numbers.join(', '))
      end

      def create_client
        params = prompt_message.merge(user: user)
        @actionable = Client.new(params)
        I18n.t('action_service.success.create_client')
      end

      def last_client
        @last_client ||= clients.last
      end
    end
  end
end
