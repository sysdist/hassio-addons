Rails.application.routes.draw do

  scope "(:locale)" do
    resources :transactions
    resources :connectors
    devise_for :users
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    #root 'application#hello'
    root to: 'visitors#index'

    get 'connectors/:id/switch_on', to: 'connectors#switch_on', as: :switch_on_connector
    get 'connectors/:id/switch_off', to: 'connectors#switch_off', as: :switch_off_connector
    get 'connectors/:id/sync', to: 'connectors#sync', as: :sync_connector
  end

  #get 'users/:id/menu', to: 'users#menu', as: :menu_user
end
