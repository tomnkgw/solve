Rails.application.routes.draw do
  get "kiyaku" => "home#kiyaku"
  get "tokutei" => "home#tokutei"
  get "privacy" => "home#privacy"
  get "contact" => "home#contact"
  
  devise_for :users
  root to: "home#index"
  resources :users
  resources :requests do
    collection do
      get 'search'
    end
    resources :proposals
    resources :favorites, only: [:create, :destroy]
  end
  resources :proposals, only: [] do
    patch :confirm_request
  end
  resources :rooms, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end
end
