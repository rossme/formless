# frozen_string_literal: true

module Api::V1
  module Concerns

    module ResponseHandler
      extend ActiveSupport::Concern

      def respond_with(resource:, status:)
        render json: response_serializer(resource), status: status
      end

      def response_serializer(resource)
        serializer = constantized_serializer.new(resource)
        action_name == 'show' ? serializer.serialize_object : serializer.serialize_collection
      end

      def constantized_serializer
        "Api::V1::#{controller_name.capitalize}Serializer".safe_constantize
      end
    end
  end
end
