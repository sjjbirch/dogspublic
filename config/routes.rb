Rails.application.routes.draw do

  # authentication pages
  devise_for :admins

  # static pages
  root to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#general_contact'
  get '/info', to: 'static_pages#information'

  # admin tools
  get '/dashboard', to: 'dashboard#tools'

  # litter pages
  resources :litters
  get 'upcoming', to: 'litters#schedule'
  get 'litter_gallery', to: 'litters#gallery'

  # dog pages
  resources :dogs
  get 'boys', to: 'dog#boys'
  get 'girls', to: 'dog#girls'
  get 'retired', to: 'dog#retired'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
