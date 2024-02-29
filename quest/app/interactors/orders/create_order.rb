# frozen_string_literal: true

module Orders
  class CreateOrder < ApplicationInteractor
    option :params

    def call
      order = yield persist
      Success(order)
    end

    private

    def persist
      order = Order.new(params)

      if order.save
        Success(order)
      else
        Failure(order.errors)
      end
    end
  end
end
