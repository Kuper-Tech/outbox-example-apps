# frozen_string_literal: true

class ValidationErrorsSerializer < ApplicationSerializer
  set_id { nil }

  attribute :full_messages do |object|
    object.full_messages
  end

  attribute :details do |object|
    object.details
  end
end
