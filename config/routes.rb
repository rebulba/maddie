Maddie::Application.routes.draw do
  get "pages/index"
  devise_for :users, :skip => [:registrations, :passwords]

  root to: 'welcome#index'

  resources :media, only: [] do
    resources :media_photos, only: [:new, :create]
  end

  resources :photos, only: [:update] do
  end

  resources :projects

  resources :pages, only: [:index, :create, :update, :destroy]

  get "pages/:url_key" => "welcome#show"

  get "projects/crop/:id" => 'projects#crop'
  get "crop/:id" => 'photos#crop'
end
