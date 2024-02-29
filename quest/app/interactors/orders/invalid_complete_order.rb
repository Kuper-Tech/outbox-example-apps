# frozen_string_literal: true

module Orders
  class InvalidCompleteOrder < ApplicationInteractor
    param :order
    option :payload, optional: true
    option :empty_message_key, default: -> { false }
    option :empty_idempotency_key, default: -> { false }

    def call
      order.transaction do
        order.completed!
        create_outbox_item
      end

      Success(order)
    rescue ActiveRecord::RecordInvalid
      Failure(order.errors)
    end

    private

    def create_outbox_item
      Sbmt::Outbox::CreateOutboxItem.call(
        OrderOutboxItem,
        attributes: outbox_item_attrs,
        partition_by: order.uuid
      )
    end

    def outbox_item_attrs
      headers = if empty_idempotency_key
        {Sbmt::Outbox::OutboxItem::IDEMPOTENCY_HEADER_NAME => ""}
      else
        {}
      end

      {
        event_key: order.uuid,
        options: {
          key: empty_message_key ? nil : order.uuid,
          headers: headers
        }.compact,
        payload: payload || OrderEncoder.new(order).encode
      }
    end
  end
end
