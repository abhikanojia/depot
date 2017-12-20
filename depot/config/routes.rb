Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get '/users/orders' => 'users#orders'
  get '/users/line_items' => 'users#line_items'
  get '/products/categories' => 'products#categories'

  resources :users

  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    resources :products
    root 'store#index', as: 'store_index', via: :all
  end


  resources :products do
    get :who_bought, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
