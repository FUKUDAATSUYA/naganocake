Rails.application.routes.draw do

  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
    post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'
    delete 'admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
  end
  devise_for :customers, skip: :all
  devise_scope :customer do
    get 'customers/sign_in' => 'customers/sessions#new', as: 'new_customer_session'
    post 'customers/sign_in' => 'customers/sessions#create', as: 'customer_session'
    delete 'customers/sign_out' => 'customers/sessions#destroy', as: 'destroy_customer_session'
    get 'customers/sign_up' => 'customers/registrations#new', as: 'new_customer_registration'
    post 'customers' => 'customers/registrations#create', as: 'customer_registration'
    get 'customers/password/new' => 'customers/passwords#new', as: 'new_customer_password'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
  	root 'admin/home#top'
  	resources :items, only:[:new, :create, :index, :show, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :order_items, only: [:update] 
	end

  get  'items' => 'customer/items#index', as: "customer_items"
  get  'items/:id' => 'customer/items#show', as: "customer_item"
  get 'cart_items' => 'customer/cart_items#index'
  post 'cart_items' => 'customer/cart_items#create'
  patch 'cart_items/:id' => 'customer/cart_items#update'
  delete 'cart_items/:id' => 'customer/cart_items#destroy'
  delete 'cart_items' => 'customer/cart_items#destroy_all'

  scope module: 'customer' do
      root 'home#top'
      resources :customers, only:[:show, :edit, :update] do
        member do
          get 'quit'
        end
      end
      resources :'mailing_addresses', only:[:index, :create, :edit, :update, :destroy]
  end

end
