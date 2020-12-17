Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:id/items', to: 'items#index'
      end
      resources :merchants, except: %i[new edit]
      namespace :items do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/:id/merchants', to: 'merchants#index'
      end
      resources :items, except: %i[new edit]
    end
  end
end
