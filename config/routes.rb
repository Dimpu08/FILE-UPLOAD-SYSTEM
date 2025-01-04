Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :file_uploads, only: [:index, :new, :create, :destroy] do
    member do
      post :share
    end
  end

  root to: 'file_uploads#index'
end
