# frozen_string_literal: true

class Client < ApplicationRecord
  belongs_to :user
  has_many :prompts, as: :actionable
end
