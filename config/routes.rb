Rails.application.routes.draw do
  resources :projects
  resources :contracts
  resources :employees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "employees#index"
end
