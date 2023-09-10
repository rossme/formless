class AddGenderToClientModel < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :gender, :string
  end
end
