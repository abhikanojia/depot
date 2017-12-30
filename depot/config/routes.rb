Rails.application.routes.draw do
  constraints user_agent: /Firefox/ do
    root 'store#index', via: :all
    match '*path', to: redirect('404'), via: :all
  end

  namespace :admin do
    get 'reports' => 'reports#index'
    get 'categories' => 'categories#index'
    get 'categories/:id/books' => 'categories#products', as: :category_books, id: '/\d/'
  end

  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'my-orders' => 'users#orders'
  get 'my-items' => 'users#line_items'

  resources :users

  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    resources :products, path: 'books'
    resources :categories
    root 'store#index', as: 'store_index', via: :all
  end


  resources :products do
    get :who_bought, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
