# frozen_string_literal: true

module Api
  module V1
    class PromptsController < BaseController
      before_action :fetch_prompts, only: %i[show index]
      around_action :action_response, only: %i[show index]

      def show; end

      def index; end

      private

      def action_response
        respond_with(resource: @prompts, status: :ok)
      end

      def fetch_prompts
        @prompts = Prompt.find_by(id: params[:id]) || Prompt.all
      end
    end
  end
end
