Rails.application.routes.draw do
  root :to => "facts#index", :as=> 'home'

  post '/search'        => 'facts#search',   :as => 'search'
  get '/search'        => 'facts#search',   :as => 'search_get'
end
