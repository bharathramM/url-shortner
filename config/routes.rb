# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'url#index'
  get '/stats', to: 'url#stats'
  get '/:shorten', to: 'url#redirector'
  post 'generate_shorten_url', to: 'url#create'
end
