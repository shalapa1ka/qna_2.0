Rails.application.routes.draw do
  get 'page/homepage'
  root 'page#homepage'
end
