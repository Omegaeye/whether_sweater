Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
      get '/forecast', to: 'weather#forecast'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
