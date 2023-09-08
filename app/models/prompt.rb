class Prompt < ApplicationRecord
  validates :user_id, presence: true

  belongs_to :user

  def message_content
    content = output.dig('choices', 0, 'message', 'content')
    content.include?('=>') ? JSON.parse(content.gsub('=>', ':')) : content
  end
end
