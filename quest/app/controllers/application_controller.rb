# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  def render_result(result, serializer_class = nil)
    if result.success?
      render_object(result.success, serializer_class)
    else
      render_validation_errors(result.failure)
    end
  end

  def render_object(object, serializer_class = nil)
    serializer_class ||= lookup_serializer(object)
    serializer = serializer_class.new(object)
    render json: serializer.serializable_hash
  end

  def render_validation_errors(errors)
    serializer = ValidationErrorsSerializer.new(errors, is_collection: false)
    render json: serializer.serializable_hash, status: :unprocessable_entity
  end

  def lookup_serializer(object)
    "#{object.class.name}Serializer".constantize
  end
end
