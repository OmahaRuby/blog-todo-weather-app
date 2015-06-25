Rails.application.routes.draw do
  devise_for :users
  
  resources :items do
    post 'mark-as-done' => 'items#mark_as_done'
  end

  root to: 'items#index'
end
