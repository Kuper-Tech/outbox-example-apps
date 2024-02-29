# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      def show
        render_object Order.find_by!(uuid: params.require(:id))
      end

      def create
        render_result ::Orders::CreateOrder.call(params: new_order_params)
      end

      private

      def new_order_params
        params
          .require(:order)
          .permit(:name, :qty, :price, :description)
      end
    end
  end
end
