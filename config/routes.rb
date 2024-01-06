Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'blog/index', to: 'blog#index'
      post 'auth/signup', to: 'authentication#sign_up'
      post 'auth/login', to: 'authentication#login'
      delete 'auth/logout', to: 'authentication#logout'
      # get 'authentication/index'
    end
  end
end