Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    get "/logout", to: "sessions#destroy"
    delete "/logout", to: "sessions#destroy"

    namespace :admin do
      root to: "static_pages#index"
      resources :static_pages
      resources :books, only: :index
      resources :authors, only: :index
      resources :publishers, only: :index
      resources :categories, only: :index
    end
    root "static_pages#index"
    get "static_pages/index"
    resources :books, only: :show

    resources :authors

  end
end
