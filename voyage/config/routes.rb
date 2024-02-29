# frozen_string_literal: true

Rails.application.routes.draw do
  root "welcome#index"

  namespace :api do
    namespace :v1 do
      resources :orders, only: [:index, :show] do
        scope module: "orders" do
          resource :processing, only: :create
          resources :inbox_items, only: [:index]
        end
      end
    end
  end
end
