# frozen_string_literal: true

class Prompt < ApplicationRecord
  include ActiveModel::Serialization
  validates :user_id, presence: true
  belongs_to :user
  belongs_to :actionable, polymorphic: true, optional: true

  def message_content
    output.dig('choices', 0, 'message', 'content')
  end
end
