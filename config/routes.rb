Rails.application.routes.draw do

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  devise_for :users,

  controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  namespace :users do
    resources :posts do
      resource :favorite, only: [:create, :destroy]
    end
    resources :favorites, only: [:index]
  end

  devise_for :publics
  devise_for :admins

  root to: 'homes#top'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
