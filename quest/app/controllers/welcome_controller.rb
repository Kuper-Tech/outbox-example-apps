# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    render json: {
      it: :works,
      ruby: RUBY_VERSION.to_s,
      rails: Rails.version.to_s
    }
  end
end
