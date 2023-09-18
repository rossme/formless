# frozen_string_literal: true

module Api::V1

  # This controller is responsible for handling the json response of the API
  class BaseController < ActionController::API
    include Api::V1::Concerns::ResponseHandler

    respond_to :json
  end
end
