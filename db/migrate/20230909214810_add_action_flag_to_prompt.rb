class AddActionFlagToPrompt < ActiveRecord::Migration[7.0]
  def change
    add_column :prompts, :actioned, :boolean, default: false
    add_reference :prompts, :actionable, polymorphic: true, null: true
  end
end
