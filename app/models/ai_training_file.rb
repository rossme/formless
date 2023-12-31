# frozen_string_literal: true

class AiTrainingFile < ApplicationRecord
  validates :training_file, :training_job, :ai_model, presence: true
end
