Rails.application.routes.draw do
  #devise_for :drivers
  #devise_for :transport_companies
  #devise_for :admins
  
  devise_for :driver, skip: [:passwords], controllers: {
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
