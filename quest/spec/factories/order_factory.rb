# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    name { Faker::Beer.name }
    qty { 1 }
    price { 4.20 }
    description { Faker::Beer.style }
    status { :pending }

    trait :completed do
      status { :completed }
    end

    trait :canceled do
      status { :canceled }
    end
  end
end
