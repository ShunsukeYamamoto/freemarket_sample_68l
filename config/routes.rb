Rails.application.routes.draw do
  

  root 'mainpages#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get 'deliver_addresses', to: 'users/registrations#new_address'
    post 'deliver_addresses', to: 'users/registrations#create_address'
  end

  resources :users ,only: :show do
    member do
      get 'logout'
      get 'new_credit_card'
    end
  end

  resources :categories , only: [:show,:index]

  resources :items, except: :index do
    get 'purchase'
    collection do
      get 'ancestry_children'
      get 'ancestry_grand_children'
    end
  end

  resources :card ,only: [:show,:new] do
    collection do
      post 'delete',to: "card#delete"
      post 'pay',to: "card#pay"
      post 'show',to: "card#show"
    end
  end
end
