Rails.application.routes.draw do



  ActiveAdmin.routes(self)

  mount ActionCable.server => '/cable'

  devise_for :users

  resources :tours
	root 'tours#index'

  get '/tours_by_owner', to: 'tours#tours_by_owner', as: 'tours_by_owner'
  delete '/tours/:id/trip_leave/', to: 'tours#trip_leave', as: 'tours_trip_leave'
  post '/tours/subscribe', to: 'tours#subscribe', as: 'tours_subscribe'
  post '/tours/:id/kick', to: 'tours#kick_user', as: 'tour_kick'
  post '/tours/:id/unsubscribe', to: 'tours#unsubscribe', as: 'tours_unsubscribe'

  post '/tours/:id/idea', to: 'tours#post_idea', as: 'tours_new_idea'
  delete '/tours/:id/ideas/', to: 'tours#delete_idea', as: 'tours_delete_idea'

  post '/tours/:id/lock', to: 'tours#lock_tour', as: 'tours_lock'
  post '/tours/:id/unlock', to: 'tours#unlock_tour', as: 'tours_unlock'
  get '/contact_us', to: 'static_pages#contactus', as: 'contact_us'
  post '/static_pages/enquiry_contact_details', to: 'static_pages#enquiry_contact_details', as: 'enquiry_contact_details'

end
