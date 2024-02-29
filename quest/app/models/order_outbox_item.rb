# frozen_string_literal: true

class OrderOutboxItem < Sbmt::Outbox::OutboxItem
  belongs_to :order, foreign_key: :event_key, primary_key: :uuid, optional: true, inverse_of: :outbox_items
end
