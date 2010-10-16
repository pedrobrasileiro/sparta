Sparta::Application.routes.draw do
  resources :tickets

  resources :projects

  devise_for :users

  resources :common_pages, :only => :show

  match ':id' => 'common_pages#show'
  root :to => 'common_pages#show', :id => 'home'
end
