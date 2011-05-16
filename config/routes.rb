Telerise::Application.routes.draw do

  resources :comments

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match "/show_video_ajax" => "videos#show_video_ajax"
  match "/hide_video_ajax" => "videos#hide_video_ajax"
  
  # voting routes
  match "/video_vote_up" => "videos#vote_up"
  match "/video_vote_down" => "videos#vote_down"
  match "/video_remove_vote_up" => "videos#remove_vote_up"
  match "/video_remove_vote_down" => "videos#remove_vote_down"
  match "/video_reverse_vote_up" => "videos#reverse_vote_up"
  match "/video_reverse_vote_down" => "videos#reverse_vote_down"
  
  match "/comment_vote_up" => "comments#vote_up"
  match "/comment_vote_down" => "comments#vote_down"
  match "/comment_remove_vote_up" => "comments#remove_vote_up"
  match "/comment_remove_vote_down" => "comments#remove_vote_down"
  match "/comment_reverse_vote_up" => "comments#reverse_vote_up"
  match "/comment_reverse_vote_down" => "comments#reverse_vote_down"
  
  
  resources :sessions
  resources :users
  resources :videos

  root :to => "videos#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
