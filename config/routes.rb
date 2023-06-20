Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'prof/show'
  get 'profile/show'
  get 'users/index'
  resources :notes
  #get 'home/index'
  root 'home#index'
  get 'home/about'
  resources :collections, only: [:index, :new, :create, :show, :destroy] do
    resources :notes
  end

  get '/users', to: 'users#index'
  post '/notes/:id/share/:user_id', to: 'notes#share', as: 'share_note'


  get '/feed', to: 'notes#feed'

  post 'profile/:id/follow' , to: "profile#follow", as: "follow"
  post 'profile/:id/unfollow' , to: "profile#unfollow", as: "unfollow"
  post 'profile/:id/accept' , to: "profile#accept", as: "accept"
  post 'profile/:id/decline' , to: "profile#decline", as: "decline"
  post 'profile/:id/cancel' , to: "profile#cancel", as: "cancel"

  get 'user_profile/:id', to: 'users#profile', as: :user_profile

  get '/profile/:id', to: 'profile#show', as: 'profile'

  # routes.rb
  get 'notes/:id/select_friend', to: 'notes#select_friend', as: 'select_friend'

# routes.rb
  post 'notes/:note_id/share_with_friend/:friend_id', to: 'notes#share_with_friend', as: 'share_note_with_friend'


  #resources :collections, only: [:index, :show]

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :shared_notes, only: [:create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
