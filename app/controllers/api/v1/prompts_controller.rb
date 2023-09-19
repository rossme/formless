# frozen_string_literal: true

module Api
  module V1
    class PromptsController < BaseController
      before_action :fetch_prompts, only: %i[show index]
      around_action :render_response, only: %i[show index]

      def show; end

      def index; end

      private

      def render_response
        render json: serializer.call, status: :ok
      end

      def fetch_prompts
        @prompts = Prompt.find_by(id: params[:id]) || Prompt.all
      end

      def serializer
        Api::V1::PromptsSerializer.new(@prompts)
      end
    end
  end
end
