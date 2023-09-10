# frozen_string_literal: true

class ChangeMobilePhoneToPhoneNumber < ActiveRecord::Migration[7.0]
  def change
    rename_column :clients, :mobile_phone, :phone_number
  end
end
