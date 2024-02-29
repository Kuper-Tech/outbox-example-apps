# frozen_string_literal: true

class OrderInboxItem < Sbmt::Outbox::InboxItem
  belongs_to :order, foreign_key: :event_key, primary_key: :uuid, optional: true, inverse_of: :inbox_items
end
