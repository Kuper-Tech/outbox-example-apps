# frozen_string_literal: true

class OrderSerializer < ApplicationSerializer
  set_id :uuid

  attributes :name,
    :qty,
    :status,
    :price,
    :description,
    :created_at,
    :updated_at
end
