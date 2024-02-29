# frozen_string_literal: true

require_relative "../lib/seeds/dsl"
using Seeds::DSL

records = {}

announce "Create orders" do
  records[:pending_orders] = create_batch 5, :order
  records[:completed_orders] = create_batch 5, :order, :completed
  records[:canceled_orders] = create_batch 5, :order, :canceled
end
