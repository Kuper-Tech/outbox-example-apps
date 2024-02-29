# frozen_string_literal: true

class AddUuidToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :uuid, :string, null: false

    safety_assured { add_index :orders, :uuid, unique: true }
  end
end
