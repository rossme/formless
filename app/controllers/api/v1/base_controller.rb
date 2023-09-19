# frozen_string_literal: true

module Api::V1

  class BaseController < ActionController::API
    respond_to :json

    def render_response
      raise NotImplementedError
    end

    def serializer
      raise NotImplementedError
    end
  end
end
