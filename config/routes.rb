Rails.application.routes.draw do
  get 'lang/change'

  resources :forums
  get 'add', to: 'forums#add'
  get 'sess/login'

  get 'sess/logout'

  get 'sess/middle'

  get 'sess/out'

  resources :users
  get 'main/main'

  get 'main/view'

  root 'main#main'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
