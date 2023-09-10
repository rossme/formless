# frozen_string_literal: true

class Prompt < ApplicationRecord
  validates :user_id, presence: true
  belongs_to :user

  # If the Prompt action created a new object, we identify it with the actionable polymorphic association
  belongs_to :actionable, polymorphic: true, optional: true

  def message_content
    output.dig('choices', 0, 'message', 'content')
  end
end
