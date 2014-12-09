Rails.application.routes.draw do

  root :to => 'urls#index'
  resources :urls, only: [:index, :create, :destroy]

  get ':short_url', to: 'urls#redirect', as: 'redirect'
  post 'urls/redirect', to: 'urls#redirect_button', as: 'redirect_button'
  post 'urls/get_short', to: 'urls#get_short'

end
