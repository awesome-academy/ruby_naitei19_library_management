Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, only: %i(new create show)
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    namespace :admin do
      root to: "static_pages#index"
      resources :static_pages
      get "/admin/books/new", to: "books#new"
      post "/admin/books/new", to: "books#create"
      resources :books, only: [:index, :new, :create]
    end
    root "static_pages#index"
    get "static_pages/index"
    resources :books, only: :show
  end
end
