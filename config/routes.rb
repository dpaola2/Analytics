Analytics::Application.routes.draw do
  match "page_views/page_data/:id" => "page_views#page_data", :as => :page_data, :via => [:get, :post, :put]
  resources :page_views, :only => [:index]
  
  match "standard_events/event_data/:id" => "standard_events#event_data", :as => :event_data, :via => [:get, :post, :put]
  match "standard_events/event_summary" => "standard_events#event_summary", :as => :event_summary, :via => [:get, :post, :put]
  resources :standard_events, :only => [:index, :show]
  
  root :to => "home#index"
  
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  
  match "events/create" => "events#create", :via => [:get, :post, :put]
  resources :events, :only => [:index, :create, :show]
end
