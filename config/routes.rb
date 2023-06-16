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

  resources :agenda_boards, :arguments, :refutations, :opinion_positions
end
