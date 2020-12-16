Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, except: %i[new edit]
      namespace :merchants do
        # resources :items, only: %i[index]
        get '/:id/items', to: 'items#index'
      end
      resources :items, except: %i[new edit]
    end
  end
end
