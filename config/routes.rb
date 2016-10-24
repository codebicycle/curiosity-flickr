Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'search#index'
  match 'search', to: 'search#index', via: [:get, :post]
  match 'people/photos', to: 'people#photos', via: [:get, :post]
  match 'people/groups', to: 'people#groups', via: [:get, :post]
end
