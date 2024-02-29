# frozen_string_literal: true

require_relative "../../pkg/server/events/order_pb"

class OrderEncoder < ApplicationEncoder
  param :order
  option :message_class, default: -> { Protobuf::OrderData::Order }

  private

  def data
    {
      id: order.uuid,
      name: order.name,
      qty: order.qty,
      status: order.status.upcase,
      description: order.description,
      price: encode_money(order.price),
      created_at: encode_time(order.created_at),
      updated_at: encode_time(order.updated_at)
    }
  end
end
