Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#index"
    get "/static_pages/index"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users
    resources :account_activations, only: :edit
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    get "/logout", to: "sessions#destroy"
    delete "/logout", to: "sessions#destroy"

    resources :books, param: :id, only: %i(show new create) do
      resources :reviews
    end

    resources :users do
      resources :like_books, only: :index
      resources :transactions, only: %i(index show destroy)
    end

    resources :books do
      resources :like_books
      resources :transactions
    end

    namespace :admin do
      root to: "static_pages#index"
      resources :static_pages
      resources :books do
        collection do
          get :export_excel
        end
      end
      resources :authors
      resources :publishers
      resources :categories
      resources :users do
        member do
          post "active"
        end
      end
      resources :transactions
    end

    resources :authors do
      resources :follows, only: %i(create destroy)
    end

    resources :publishers, only: %i(show index) do
      resources :follows, only: %i(create destroy)
    end
  end
end
