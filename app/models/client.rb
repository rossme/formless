# frozen_string_literal: true

class Client < ApplicationRecord
  validates :user_id, presence: true
  belongs_to :user
  has_many :prompts, as: :actionable
end
