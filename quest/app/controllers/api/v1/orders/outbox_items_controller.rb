# frozen_string_literal: true

module Api
  module V1
    module Orders
      class OutboxItemsController < ApplicationController
        def index
          order = Order.find_by!(uuid: params.require(:order_id))
          scope = order.outbox_items.order(id: :desc)
          render_object scope.to_a, OrderOutboxItemSerializer
        end
      end
    end
  end
end
