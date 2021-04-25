Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resource :users, only: %i[create]
      get '/forecast', to: 'weather#forecast'
      get '/backgrounds', to:'images#backgrounds'
      post '/sessions', to: 'users/sessions#authenticate'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
