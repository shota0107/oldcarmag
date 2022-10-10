Rails.application.routes.draw do
  devise_scope :user do
    post 'users/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end
  devise_for :users
  devise_for :publics
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
