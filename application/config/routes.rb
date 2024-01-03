Rails.application.routes.draw do
  resources :bills
  resources :enrollments
  resources :students
  resources :institutions

  # Defines the root path route ("/")
  root "institutions#index"
  get 'student', to: "student#index"
  get 'enrollment', to: "enrollment#index"
  get 'bill', to: "bill#index"
end
