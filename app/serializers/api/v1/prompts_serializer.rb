# frozen_string_literal: true

module Api
  module V1
    class PromptsSerializer

      def initialize(resource)
        @resource = resource
      end

      attr_reader :resource

      def serialize_object
        resource.serializable_hash
      end

      def serialize_collection
        resource(&:serializable_hash)
      end
    end
  end
end
