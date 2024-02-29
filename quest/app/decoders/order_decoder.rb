# frozen_string_literal: true

require_relative "../../pkg/server/events/order_pb"

class OrderDecoder < ApplicationDecoder
  option :message_klass, default: -> { Protobuf::OrderData::Order }

  def decode
    object = message_klass.decode(data)

    {
      id: object.id,
      name: object.name,
      qty: object.qty,
      description: object.description,
      status: object.status.downcase,
      price: decode_money(object.price),
      updated_at: decode_time(object.updated_at),
      created_at: decode_time(object.created_at)
    }
  end
end
