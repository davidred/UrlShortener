Rails.application.routes.draw do

  root :to => 'urls#index'
  resources :urls, only: [:index, :create, :destroy]

  get 'urls/:short_url', to: 'urls#redirect', as: 'redirect'

end
