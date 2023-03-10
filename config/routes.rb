Rails.application.routes.draw do
  #devise_for :drivers
  #devise_for :transport_companies
  #devise_for :admins

  devise_for :drivers, skip: [:passwords], controllers: {
  registrations: "public/driver/registrations",
  sessions: 'public/driver/sessions'
  }

  devise_for :transport_companies, skip: [:passwords], controllers: {
  registrations: "public/transport_company/registrations",
  sessions: 'public/transport_company/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    patch 'drivers/all/:id' => 'drivers#update_all', as: 'driver_all'
    resources :drivers, only: [:index, :show, :update, :edit]
    resources :transport_companies, only: [:index, :show, :edit, :update]
    resources :licenses, only: [:index, :create]
    resources :possession_licenses, only: [:create, :destroy]
    resources :companies, only: [:new, :create, :index, :show, :edit, :update] do
       resources :bookmarks, only: [:destroy]
      resources :reviews, only: [:new, :create, :index, :show, :edit, :update] do
        resources :review_comments, only: [:create]
      end
    end
    resources :bookmarks, only: [:index, :create]
    resources :rooms, only: [:create, :show, :index] do
      resources :messages, only: [:create]
    end
    get 'contacts/contact_with_text' => 'contacts#new_with_text', as: 'contact_with_text'
    resources :contacts, only: [:new, :create, :index, :edit, :update, :show]
  end

  namespace :admin do
    root to: 'homes#top'
    resources :drivers, only: [:index, :show, :update]
    resources :transport_companies, only: [:index, :show, :update]
    resources :licenses, only: [:create, :index, :update, :edit, :destroy]
    resources :companies, only: [:index, :show, :edit, :update, :destroy] do
      resources :reviews, only: [:index, :show, :update] do
        resources :review_comments, only: [:update]
      end
    end
    get 'contacts/index_ok' => 'contacts#index_ok', as: 'contacts_ok'
    resources :contacts, only: [:index, :update, :show]

  end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
