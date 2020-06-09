Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'forecast', to: 'forecast#index'
      get 'backgrounds', to: 'backgrounds#index'
      post 'users', to: 'users#create'
      post 'sessions', to: 'sessions#show'
      post 'road_trip', to: 'road_trips#show'
    end
  end
end
