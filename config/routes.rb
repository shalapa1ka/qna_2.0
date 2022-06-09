# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :questions do

    member { post :vote }
    collection { delete :cancel_vote }

    resources :answers, except: :index do

      member do
        patch :set_best
        post :vote
      end

      collection { delete :cancel_vote }
    end
  end

  delete 'attachments/destroy'

  root 'questions#index'
end
