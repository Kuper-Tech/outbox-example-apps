# frozen_string_literal: true

module Orders
  class ProcessOrder < ApplicationInteractor
    param :order

    def call
      order.processed!

      Success(order)
    rescue ActiveRecord::RecordInvalid
      Failure(order.errors)
    end
  end
end
