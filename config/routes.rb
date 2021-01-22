Rails.application.routes.draw do
  get "kiyaku" => "home#kiyaku"
  get "tokutei" => "home#tokutei"
  get "privacy" => "home#privacy"
  get "contact" => "home#contact"
  
  devise_for :users
  root to: "home#index"
  resources :users
  resources :requests do
    resources :proposals
  end
  
end
