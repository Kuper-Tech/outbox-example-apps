# frozen_string_literal: true

class OrderInboxItemSerializer < ApplicationSerializer
  set_id :uuid

  attributes :event_key,
    :bucket,
    :status,
    :options,
    :errors_count,
    :error_log,
    :processed_at,
    :created_at,
    :updated_at

  attribute :payload do |object|
    OrderDecoder.decode(object.payload)
  end
end
