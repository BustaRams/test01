Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :users
  resources :tours
	root 'tours#index'

  post '/tours/subscribe', to: 'tours#subscribe', as: 'tours_subscribe'
  post '/tours/:id/kick', to: 'tours#kick_user', as: 'tour_kick'
  post '/tours/:id/unsubscribe', to: 'tours#unsubscribe', as: 'tours_unsubscribe'
end
