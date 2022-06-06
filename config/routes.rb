# frozen_string_literal: true

Rails.application.routes.draw do
  get 'page/homepage'
  root 'page#homepage'
end
