# frozen_string_literal: true

FactoryBot.define do
  factory :order_outbox_item do
    order
    payload { "test-payload" }
    bucket { 0 }

    trait :with_payload do
      after(:build) do |item, ev|
        next unless ev.order || item.order
        item.payload = OrderEncoder.new(ev.order || item.order).encode
      end
    end
  end
end
