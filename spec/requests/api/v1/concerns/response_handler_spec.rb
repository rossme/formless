# frozen_string_literal: true

require 'rails_helper'
require 'pry'

RSpec.describe Api::V1::Concerns::ResponseHandler do
  describe '#respond_with' do
    it 'responds with a collection' do
      collection = create_list(:prompt, 3)
      controller = double('controller', action_name: 'index', controller_name: 'prompts')
      allow(controller).to receive(:constantized_serializer).and_return(Api::V1::PromptsSerializer)
      allow(controller).to receive(:render).with(json: Api::V1::PromptsSerializer.new(collection).serialize_collection, status: :ok)
      controller.extend(Api::V1::Concerns::ResponseHandler)
      controller.respond_with(resource: collection, status: :ok)
      expect(controller).to have_received(:render).with(json: Api::V1::PromptsSerializer.new(collection).serialize_collection, status: :ok)
    end
  end
end
