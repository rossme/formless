# frozen_string_literal: true

class User < ApplicationRecord
  include OpenAiRateLimitable

  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :timeoutable

  has_many :prompts, dependent: :destroy
  has_many :clients, dependent: :destroy
end
