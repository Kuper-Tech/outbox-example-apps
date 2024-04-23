# frozen_string_literal: true

Rails.application.routes.draw do
  mount Sbmt::Outbox::Engine => "/outbox-ui"

  root "welcome#index"

  namespace :api do
    namespace :v1 do
      resources :orders, only: [:show, :create] do
        scope module: "orders" do
          resource :completion, only: :create do
            member do
              post :invalid_create
            end
          end
          resources :outbox_items, only: [:index]
        end
      end
    end
  end
end
