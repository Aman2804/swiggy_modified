Rails.application.routes.draw do
  resources :coupons
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root "welcome#index"
  get 'welcome/index'
  devise_for :users,controllers: {
        registrations: 'users/registrations',
        sessions: 'users/sessions'
 }
      
  devise_scope :user do
      get 'profile', to: 'users/registrations#show'
      get 'restaurants_list', to: 'users/registrations#restaurants_list'
      get 'add', to: 'users/registrations#add'
      get 'search', to: 'user/registrations#search'
  end

  scope path: 'users/:users_id' do
  	resources :addresses, except: :show
    resources :restaurants 
    resources :roles
    resources :vehicles
    resources :carts
    resources :orders
	end
  scope path:'oders/:orders_id' do 
      resources :payments
  end
  scope path:'restaurants/:restaurants_id' do 
      resources :restaurant_items
  end
    resources :cart_items
    resources :items

end
