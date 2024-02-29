# frozen_string_literal: true

class Order < ApplicationRecord
  enum :status, {
    pending: "pending",
    completed: "completed",
    canceled: "canceled"
  }

  has_many :outbox_items, class_name: "OrderOutboxItem", foreign_key: :event_key, primary_key: :uuid, inverse_of: :order

  validates :name, :qty, :price, presence: true

  after_initialize do
    self.uuid ||= Nanoid.generate(size: 12)
  end
end
