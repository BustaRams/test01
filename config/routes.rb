Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
	resources :trips
	root 'trips#index'
end
