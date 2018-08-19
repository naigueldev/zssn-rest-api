Rails.application.routes.draw do
  resources :survivors, only: [:index, :create, :update, :show] do
  	post :report_infection, on: :member
  end

  post :trade, to: 'trades#trade'

end
