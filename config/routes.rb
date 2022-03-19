Rails.application.routes.draw do
  
  # authentication pages
  devise_for :users
  devise_for :admins

  # static pages
  root to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#general_contact'
  get '/info', to: 'static_pages#information'

  # admin tools
  get '/dashboard', to: 'dashboard#tools'
  get '/userlist', to: 'dashboard#list_all_users'

  # litter pages
  resources :litters
  get 'upcoming', to: 'litters#schedule'
  get 'litter_gallery', to: 'litters#gallery'

  # dog pages
  resources :dogs do
    resources :adverts, except: :index
  end
  get 'adverts', to: 'adverts#index'#, as: :adverts
  get '/my_ads', to: 'adverts#myads'
  get '/buy', to: 'adverts#buy'

  get 'boys', to: 'dog#boys'
  get 'girls', to: 'dog#girls'
  get 'retired', to: 'dog#retired'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/payments', to: 'payments#index'

end
