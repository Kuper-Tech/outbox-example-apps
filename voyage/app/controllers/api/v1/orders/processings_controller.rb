# frozen_string_literal: true

module Api
  module V1
    module Orders
      class ProcessingsController < ApplicationController
        def create
          order = Order.find_by!(uuid: params.require(:order_id))
          render_result ::Orders::ProcessOrder.call(order)
        end
      end
    end
  end
end
