Rails.application.routes.draw do

  ActiveAdmin.routes(self)

  mount ActionCable.server => '/cable'

  devise_for :users

  resources :tours
	root 'tours#index'

  post '/tours/subscribe', to: 'tours#subscribe', as: 'tours_subscribe'
  post '/tours/:id/kick', to: 'tours#kick_user', as: 'tour_kick'
  post '/tours/:id/unsubscribe', to: 'tours#unsubscribe', as: 'tours_unsubscribe'

  post '/tours/:id/idea', to: 'tours#post_idea', as: 'tours_new_idea'
  delete '/tours/:id/ideas/', to: 'tours#delete_idea', as: 'tours_delete_idea'

  post '/tours/:id/lock', to: 'tours#lock_tour', as: 'tours_lock'
  post '/tours/:id/unlock', to: 'tours#unlock_tour', as: 'tours_unlock'
end
