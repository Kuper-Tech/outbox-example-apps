# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_enum :order_status, %w[completed processed]

    create_table :orders do |t|
      t.string :uuid, null: false
      t.string :name, null: false
      t.integer :qty, null: false
      t.enum :status, enum_type: :order_status, null: false, default: :completed
      t.decimal :price, precision: 10, scale: 2, null: false
      t.text :description
      t.timestamps null: false

      t.index :uuid, unique: true
    end
  end
end
