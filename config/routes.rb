# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  mount ActionCable.server => '/cable'

  root 'seats#index'
  post '/seats/update_selected_seats', to: 'seats#update_selected_seats'
  post '/seats/reserve_selected_seats', to: 'seats#reserve_selected_seats'
end
