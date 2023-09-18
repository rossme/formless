# frozen_string_literal: true

module Api
  module V1
    class PromptsController < BaseController

      def show
        prompt = Prompt.find(params[:id])
        respond_with(resource: prompt, status: :ok)
      end

      def index
        prompts = Prompt.all
        respond_with(resource: prompts, status: :ok)
      end
    end
  end
end
