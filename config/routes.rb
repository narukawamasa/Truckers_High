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
    resources :drivers, only: [:index, :show, :update]
    resources :transport_companies, only: [:index, :show]
    resources :licenses, only: [:index, :create]
    resources :possession_licenses, only: [:create, :destroy]
    resources :companies, only: [:new, :create, :index, :show, :edit, :update]
  end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
