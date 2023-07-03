Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: "weather#index"
  namespace :weather do
    get 'index'
    get 'result'
  end
end
