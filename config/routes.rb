Rails.application.routes.draw do
  resources :survivors, only: [:index, :create, :update, :show] do
  	post :report_infection, on: :member
  end

  post :trade, to: 'trades#trade'

  resource :reports, only: [] do
   get :infected, to: 'reports#infected_survivors'
   get 'non-infected', to: 'reports#non_infected'
   get :inventories, to: 'reports#inventories_by_survivor'
   get :points, to: 'reports#lost_infected_points'
 end

end
