# frozen_string_literal: true

module InboxImporters
  class OrderImporter < BaseImporter
    def call
      decoded_payload = OrderDecoder.decode(payload)

      order = build_order(decoded_payload)

      if order.save
        Success(order)
      else
        Failure(order.errors)
      end
    end

    private

    def build_order(payload)
      uuid = payload.fetch(:id)
      order = Order.find_by(uuid: uuid) || Order.new(uuid: uuid)

      order.assign_attributes(
        status: payload.fetch(:status),
        name: payload.fetch(:name),
        qty: payload.fetch(:qty),
        description: payload.fetch(:description),
        price: payload.fetch(:price)
      )

      order
    end
  end
end
