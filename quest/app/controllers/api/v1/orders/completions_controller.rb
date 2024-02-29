# frozen_string_literal: true

module Api
  module V1
    module Orders
      class CompletionsController < ApplicationController
        def create
          order = Order.find_by!(uuid: params.require(:order_id))
          render_result ::Orders::CompleteOrder.call(order)
        end

        def invalid_create
          order = Order.find_by!(uuid: params.require(:order_id))

          order_params = case params.require(:invalid_attr)
          when "proto-payload"
            {payload: params.require(:invalid_value)}
          when "empty-message-key"
            {empty_message_key: true}
          when "empty-idempotency-key"
            {empty_idempotency_key: true}
          end

          render_result ::Orders::InvalidCompleteOrder.call(order, **order_params)
        end
      end
    end
  end
end
