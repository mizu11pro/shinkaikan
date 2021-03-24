Rails.application.routes.draw do
  devise_scope :user do
    post 'users/guest_sign_in' => 'users/sessions#new_guest'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
  }

  scope module: :users do
    root 'homes#index'

    get 'followings' => 'relationships#followings'
    get 'followers' => 'relationships#followers'
    resource :relationships, only: [:create, :destroy]

    resources :users, except: [:new, :create, :destroy] do
      get 'favorites' => 'favorites#index'
      resources :movies do
        resources :favorites, only: [:destroy]
      end
      collection do
        get 'search'
      end
    end

    resources :notifications, only: [:index]
    resources :messages, only: [:show, :create]
    resources :homes, except: [:new, :index, :show]
    resources :genres, except: [:show]
    resources :movies do
      resources :movie_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
      collection do
        get 'search'
      end
    end
  end
end
