Rails.application.routes.draw do
  
  #get 'jobs/add'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "posts#homepage"
  get "jobs/add/:name", to: "jobs#add", as: "jobs_add"
  get "posts/responseToPost/:id", to: "posts#responseToPost", as: "posts_responseToPost"
  get "posts/homepage", to: "posts#homepage", as: "posts_homepage"
  get "posts/jobs/:job/:category", to: "posts#jobs_category", as: "posts_jobscategory"
  get "posts/apply/:id", to: "posts#apply", as: "posts_apply"
  get "posts/cancelled/:id", to: "posts#cancelled", as: "posts_cancelled"
  get "posts/user/:id", to: "posts#user", as: "posts_user"
  resources :posts
  devise_for :users, controllers: {
        sessions: 'users/sessions',
         registrations: 'users/registrations',
         passwords: 'users/passwords'
      }
end
