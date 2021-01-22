Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :orders, only: %i[index new create show] do
    member do
      put :fulfill
    end
  end

  root to: 'orders#index'
end
