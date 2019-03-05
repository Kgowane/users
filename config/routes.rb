Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'products#index'
  # resources :users, only: [:show]
  resources :products do
    resources :comments
    collection do
      post '/:id/buy_product', to: 'products#buy_product', as: 'buy_product'
    end
  end
end
