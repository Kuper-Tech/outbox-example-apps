# frozen_string_literal: true

require_relative "../../pkg/client/quest/events/order_pb"

class OrderDecoder < ApplicationDecoder
  option :message_klass, default: -> { Protobuf::OrderData::Order }

  def decode
    payload = message_klass.decode(data)

    {
      id: payload.id,
      name: payload.name,
      qty: payload.qty,
      description: payload.description,
      status: payload.status.downcase,
      price: decode_money(payload.price),
      updated_at: decode_time(payload.updated_at),
      created_at: decode_time(payload.created_at)
    }
  end
end
