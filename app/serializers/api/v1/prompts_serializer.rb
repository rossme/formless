# frozen_string_literal: true

module Api
  module V1
    class PromptsSerializer

      def initialize(prompts)
        @prompts = prompts
      end

      attr_reader :prompts

      def call
        prompts.is_a?(Prompt) ? serializable_object : serializable_collection
      end

      def serializable_collection
        prompts.map(&:serializable_hash)
      end

      def serializable_object
        prompts.serializable_hash
      end
    end
  end
end
