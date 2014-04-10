Analytics::Application.routes.draw do
  resources :page_views, :only => [:index]
  resources :standard_events, :only => [:index, :show]
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  match "events/create" => "events#create", :via => [:get, :post, :put]
  resources :events, :only => [:index, :create, :show]
end
