Rails.application.routes.draw do

  # devise_for :movies
  scope module: :users do
    root 'users#show'
    get 'homes' => 'homes#top', as: :report
    resources :homes, only: [:create,:edit,:update,:destroy]
    resources :users, only: [:index, :edit, :update]
    resources :movies
  end

  devise_for :users, controllers: {
    sessions:       'users/sessions',
    registrations:  'users/registrations',
    passwords:      'users/passwords',
  }

  # scope module: :admins do
  #   get 'homes' => 'homes#top'
  #   resources :homes, only: [:show, :edit, :create, :update, :destroy]
  #   # resources :reportimages, only: [:new, :create, :index, :show, :destroy]
  # end

  # devise_for :admins, controllers: {
  #   sessions:       'admins/sessions',
  #   registrations:  'admins/registrations',
  #   passwords:      'admins/passwords',
  # }

  # scope module: :customers do
  #   root 'homes#index'
  # end
  # devise_for :customers, controllers: {
  #   sessions:       'customers/sessions',
  #   registrations:  'customers/registrations',
  #   passwords:      'customers/passwords',
  # }

end
