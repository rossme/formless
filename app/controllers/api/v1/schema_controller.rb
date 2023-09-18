# frozen_string_literal: true

module Api
  module V1
    class SchemaController < BaseController

      def index
        if File.exist?(schema_path)
          send_file schema_path, type: 'application/x-yaml', disposition: 'inline'
        else
          render plain: 'API schema not found', status: :not_found
        end
      end

      def schema_path
        Rails.root.join('config', 'openapi', 'api_v1_schema.yaml')
      end
    end
  end
end
