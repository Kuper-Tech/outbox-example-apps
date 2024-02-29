# frozen_string_literal: true

module Orders
  class CompleteOrder < ApplicationInteractor
    param :order

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
        attributes: outbox_item_attrs
      )
    end

    def outbox_item_attrs
      {
        event_key: order.uuid,
        options: {key: order.uuid},
        payload: OrderEncoder.new(order).encode
      }
    end
  end
end
