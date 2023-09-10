# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :prompts, dependent: :destroy
  has_many :clients, dependent: :destroy
end
