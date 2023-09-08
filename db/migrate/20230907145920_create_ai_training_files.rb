# frozen_string_literal: true

class CreateAiTrainingFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :ai_training_files do |t|
      t.text :training_file
      t.json :training_job
      t.text :fine_tune_model
      t.text :ai_model

      t.timestamps
    end
  end
end
