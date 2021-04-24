Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/users', to: 'users/sessions#create'
      get '/forecast', to: 'weather#forecast'
      get '/backgrounds', to:'images#backgrounds'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
