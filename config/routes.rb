Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/most_revenue', to: 'business_intelligence#most_revenue'
        get '/most_items', to: 'business_intelligence#most_items_sold'
        get '/:id/items', to: 'items#index'
      end
      resources :merchants, except: %i[new edit]
      namespace :items do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/:id/merchants', to: 'merchants#index'
      end
      resources :items, except: %i[new edit]
      get '/revenue', to: 'business_intelligence#revenue_date_range'
    end
  end
end
