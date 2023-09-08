# frozen_string_literal: true

class Prompt < ApplicationRecord
  validates :user_id, presence: true
  belongs_to :user

  def message_content
    output.dig('choices', 0, 'message', 'content')
  end
end
