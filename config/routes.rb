# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :questions do
    member do
      post :vote
      post :subscribe_update
      post :subscribe_new_answer
      patch :unsubscribe_update
      patch :unsubscribe_new_answer
    end
    collection { delete :cancel_vote }

    resources :answers, except: :index do
      member do
        patch :set_best
        post :vote
      end

      collection { delete :cancel_vote }
    end
  end

  namespace :api do
    namespace :v1 do
      resource :profiles do
        get :me, on: :collection
      end
      resources :questions, only: %i[index show create] do
        resources :answers, only: %i[index show create]
      end
    end
  end

  delete 'attachments/destroy'

  root 'questions#index'
end
