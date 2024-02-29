# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      def index
        @pagy, orders = pagy(Order.order(id: :desc))
        render_list(orders, OrderSerializer)
      end

      def show
        render_object Order.find_by!(uuid: params.require(:id))
      end
    end
  end
end
