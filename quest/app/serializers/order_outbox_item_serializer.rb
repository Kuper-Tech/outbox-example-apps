# frozen_string_literal: true

class OrderOutboxItemSerializer < ApplicationSerializer
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
    OrderDecoder.new(object.payload).decode
  end
end
