Rails.application.routes.draw do
  root to:'home#index'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get 'sign_up', :to => 'users/registrations#new'
    get 'sign_in', :to => 'users/sessions#new'
    get 'sign_out', :to => 'users/sessions#destroy'
  end

  resources :arguments, :refutations, :opinion_positions, :opinion_connections

  resources :agenda_boards do
    collection do
      get 'index_created_by_current_user', as: 'current_user_created'
      get 'index_with_opinion_posted_by_current_user', as: 'current_user_posted_opinion'
      get 'index_searched_by_category', as: 'category_search'
    end
  end
end
