Sparta::Application.routes.draw do

  resources :projects, :except => [:show] do
    resources :project_users 
    resources :tickets do
      post :sort, :on => :collection

      resources :comments
    end
  end

  # match "/stories/:name" => redirect {|params| "/posts/#{params[:name].pluralize}" }
  match '/projects/:id' => redirect("/projects/%{id}/tickets")

  devise_for :users

  resources :common_pages, :only => :show

  match ':id' => 'common_pages#show'
  root :to => 'common_pages#show', :id => 'home'
end
