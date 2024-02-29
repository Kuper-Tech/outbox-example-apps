# frozen_string_literal: true

class CreateOrderInboxItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_inbox_items do |t|
      t.string :uuid, null: false
      t.string :event_key, null: false
      t.integer :bucket, null: false
      t.integer :status, null: false, default: 0
      t.jsonb :options
      t.binary :payload, null: false
      t.integer :errors_count, null: false, default: 0
      t.text :error_log
      t.timestamp :processed_at
      t.timestamps null: false
    end

    add_index :order_inbox_items, :uuid, unique: true
    add_index :order_inbox_items, [:status, :bucket]
    add_index :order_inbox_items, :event_key
    add_index :order_inbox_items, :created_at
  end
end
