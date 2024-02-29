# frozen_string_literal: true

require_relative "../../pkg/client/quest/events/order_pb"

FactoryBot.define do
  factory :order_inbox_item do
    order
    payload { (+"\n\f29dSQcVvXe1r\x12)Racer 5 India Pale Ale, Bear Republic Bre\x18\x01 \x01*\x14European Amber Lager2\t\n\x03RUB\x10\x04\x18\x14:\f\b\xE7\xF8\x8C\xA3\x06\x10\xF0\xB4\xA5\xED\x01B\f\b\x85\xE0\x92\xA3\x06\x10\xC8\xB0\xB7\xB6\x01").force_encoding("ASCII-8BIT") }
    bucket { 0 }

    trait :payload_with_empty_name do
      payload { (+"\n\f29dSQcVvXe1r\x18\x01 \x01*\x14European Amber Lager2\t\n\x03RUB\x10\x04\x18\x14:\f\b\xE7\xF8\x8C\xA3\x06\x10\xF0\xB4\xA5\xED\x01B\f\b\x85\xE0\x92\xA3\x06\x10\xC8\xB0\xB7\xB6\x01").force_encoding("ASCII-8BIT") }
    end
  end
end
