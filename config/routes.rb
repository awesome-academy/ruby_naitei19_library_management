Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#index"
    get "/static_pages/index"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    get "/logout", to: "sessions#destroy"
    delete "/logout", to: "sessions#destroy"

    resources :books, only: %i(show new create) do
      resources :reviews
    end

    resources :users do
      resources :like_books, only: :index
    end

    namespace :admin do
      root to: "static_pages#index"
      resources :static_pages
      resources :books, only: :index
      resources :authors, only: :index
      resources :publishers, only: [:index, :new, :create]
      resources :categories, only: [:index, :new, :create]
    end

    resources :books, only: :show do
      resources :transactions
    end

    resources :authors

  end
end
