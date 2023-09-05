Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "pages#home"
    get "/books", to: "pages#books"

    namespace :admin do
      root to: "static_pages#index"
      resources :static_pages
    end
  end
end
