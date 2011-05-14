Telerise::Application.routes.draw do

  resources :comments

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match "/vote_up" => "videos#vote_up"
  match "/vote_down" => "videos#vote_down"
  match "/remove_vote_up" => "videos#remove_vote_up"
  match "/remove_vote_down" => "videos#remove_vote_down"
  match "/reverse_vote_up" => "videos#reverse_vote_up"
  match "/reverse_vote_down" => "videos#reverse_vote_down"
  
  resources :sessions
  resources :users
  resources :videos

  root :to => "videos#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
