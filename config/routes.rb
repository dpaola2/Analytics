Analytics::Application.routes.draw do
  get "events/index"
  get "events/new"
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  match "events/create" => "events#create", :via => [:get, :post, :put]
  resources :events
end
