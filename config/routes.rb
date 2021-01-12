Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions:       'users/sessions',
    registrations:  'users/registrations',
    passwords:      'users/passwords',
  }

  # namespace :users do
  scope module: :users do
    root 'movies#index'
    get 'homes' => 'homes#top', as: :report

    get 'followings' => 'relationships#followings'
    get 'followers' => 'relationships#followers'
    resource :relationships, only: [:create, :destroy]

    resources :homes, except: [:new, :index, :show]
    resources :users, except: [:new, :create, :destroy]
    resources :movies
    resources :genres, except: [:show]

  end

  # resources :users do
  #   resource :relationships, only: [:create, :destroy]
  # end

end