# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

# Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
# Can be used by load balancers and uptime monitors to verify that the app is live.
Rails.application.routes.draw do
  get 'dashboards/index'
  devise_for :users

  # Définir la page d'accueil
  root to: 'artworks#index'

  # Routes pour les artworks
  resources :artworks, except: :destroy do
    resources :bookings, only: [:create, :update] do
      member do
        patch :accept
        patch :decline
      end
    end
  end

  delete 'artworks/:id', to: 'artworks#destroy', as: :delete_artwork

  # Route pour le tableau de bord
  get '/dashboards', to: 'dashboards#show', as: :dashboard

  # Routes pour les bookings
  resources :bookings, only: [:destroy] do
    member do
      patch :accept
      patch :decline
    end
  end

  # Routes pour le dashboard
  resources :dashboards, only: [:index]



end
