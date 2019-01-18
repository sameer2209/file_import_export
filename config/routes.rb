Rails.application.routes.draw do
 	root 'pages#index'

 	resources :pages, only: [:index]
 	resources :inventory, only: [:new, :create]

end
