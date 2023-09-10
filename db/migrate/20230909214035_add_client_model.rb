class AddClientModel < ActiveRecord::Migration[7.0]
  def up
    create_table :clients do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :email
      t.string :mobile_phone
      t.string :date_of_birth
      t.string :national_number
      t.string :nationality
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :clients
  end
end
