Analytics::Application.routes.draw do
  resources :page_views, :only => [:index]
  match "page_views/page_data/:id" => "page_views#page_data", :as => :page_data, :via => [:get, :post, :put]
  resources :standard_events, :only => [:index, :show]
  match "standard_events/event_data/:id" => "standard_events#event_data", :as => :event_data, :via => [:get, :post, :put]
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  match "events/create" => "events#create", :via => [:get, :post, :put]
  resources :events, :only => [:index, :create, :show]
end
