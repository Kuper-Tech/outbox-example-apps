# frozen_string_literal: true

module InboxImporters
  class BaseImporter < ApplicationInteractor
    param :inbox_item
    param :payload

    def call
      raise NotImplementedError
    end
  end
end
