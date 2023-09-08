# frozen_string_literal: true

class CreatePrompts < ActiveRecord::Migration[7.0]
  def up
    create_table :prompts do |t|
      t.text :input
      t.json :output
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :prompts
  end
end
