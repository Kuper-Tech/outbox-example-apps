# frozen_string_literal: true

module Api
  module V1
    module Orders
      class InboxItemsController < ApplicationController
        def index
          order = Order.find_by!(uuid: params.require(:order_id))
          scope = order.inbox_items.order(id: :desc)
          @pagy, inbox_items = pagy(scope)
          render_list(inbox_items, OrderInboxItemSerializer)
        end
      end
    end
  end
end
