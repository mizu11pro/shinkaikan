Rails.application.routes.draw do

  scope module: :admins do
    get 'homes' => 'homes#top'
    resources :homes, only: [:show, :edit, :create, :update, :destroy]
    # resources :reportimages, only: [:new, :create, :index, :show, :destroy]
  end

  devise_for :admins, controllers: {
    sessions:       'admins/sessions',
    registrations:  'admins/registrations',
    passwords:      'admins/passwords',
  }

  scope module: :customers do
    root 'homes#index'
  end
  devise_for :customers, controllers: {
    sessions:       'customers/sessions',
    registrations:  'customers/registrations',
    passwords:      'customers/passwords',
  }

end
