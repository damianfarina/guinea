Rails.application.routes.draw do
  resources :veterinaries
  resources :veterinarians
  resources :admissions

  root 'admissions#index'
end
