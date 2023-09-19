# frozen_string_literal: true

class Prompt < ApplicationRecord
  validates :user_id, presence: true
  validates :input, presence: true

  paginates_per 18 # kaminari

  belongs_to :user
  belongs_to :actionable, polymorphic: true, optional: true

  def message_content
    output.dig('choices', 0, 'message', 'content')
  end
end
