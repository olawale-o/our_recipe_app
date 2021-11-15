Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'confirmations'
  }, path_names: {
    sign_in: 'login',
    sign_up: 'create_account',
    sign_out: 'seeyousoon'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'foods#index'

  resources :foods, only: [:index, :create, :show, :new, :destroy]
  resources :recipes, only: [:index, :create, :show, :new, :destroy]
  resources :recipes do
    resources :recipe_foods, only: [:new]
  end

  resources :recipe_foods, only: [:create, :destroy, :edit, :update]

  get '/public_recipes', to: 'recipes#public_recipes', as: 'public_recipes'
end
