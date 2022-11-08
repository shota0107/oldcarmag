Rails.application.routes.draw do

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end




   devise_for :users, controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'

  }

    devise_for :admins


  scope module: :public do
      root to: 'homes#top'
    resources :users, only: [:show, :edit, :update, :destroy]
    resources :posts do
      collection do
        get 'search'
      end
      resource :favorite, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

  end






  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
