Rails.application.routes.draw do
  devise_for :users
  
  resources :blogs do
    resources :entries do
      post 'mark-as-done' => 'entries#mark_as_done'
    end
  end
  
  root to: 'blogs#index'
end
