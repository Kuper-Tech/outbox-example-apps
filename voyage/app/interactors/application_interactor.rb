# frozen_string_literal: true

class ApplicationInteractor
  extend Dry::Initializer
  include Dry::Monads[:result, :do]

  def self.call(...)
    new(...).call
  end
end
