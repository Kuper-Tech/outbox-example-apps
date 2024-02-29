# frozen_string_literal: true

class Order < ApplicationRecord
  enum :status, {
    completed: "completed",
    processed: "processed"
  }

  has_many :inbox_items, class_name: "OrderInboxItem", foreign_key: :event_key, primary_key: :uuid, inverse_of: :order

  validates :name, :qty, :price, presence: true

  after_initialize do
    self.uuid ||= Nanoid.generate(size: 12)
  end
end
