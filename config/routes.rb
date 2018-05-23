Rails.application.routes.draw do
  scope protocol: SECURE_PROTOCOL do

  # ╭─ Public Accesible URL's / Path's
    root to: 'home#show'

    get '/mobile', action: :mobile, controller: :home

    resources :neighborhoods, only: [:show] do
      resources :works, only: [:show]
      resources :meetings, only: [:index, :show]
      member do
        get :agreement
        get :about
        get '/:filters', action: :show, controller: :neighborhoods, as: :filtered_work
      end
    end

    resources :works, only: [] do
      resources :meetings, only: [:index, :show]
    end

    resources :meetings, only: [] do
      resources :works, only: [:index]
    end

    get '/components', action: :index, controller: :components
    get '/admin', to: redirect('/admin/dashboard')
  # ╰─  End of Public Accesible URL's / Path's


  # ╭─ Private Accesible URL's / Path's
    namespace :admin do
      get  '/signin',   action: :new,     controller: :user_sessions
      post '/signin',   action: :create,  controller: :user_sessions
      post '/signout',  action: :destroy, controller: :user_sessions

      # ╭─ AJAX Accesible URL's / Path's
      namespace :ajax do
        resources :neighborhoods, only: [] do
          post '/documents/upload', action: :upload, controller: :documents
          delete '/documents/:id', action: :destroy, controller: :documents, as: :document

          post '/photos/upload', action: :upload, controller: :photos
          delete '/photos/:id', action: :destroy, controller: :photos, as: :photo
        end
        resources :works, only: [] do
          post '/documents/upload', action: :upload, controller: :documents
          delete '/documents/:id', action: :destroy, controller: :documents, as: :document

          post '/photos/upload', action: :upload, controller: :photos
          delete '/photos/:id', action: :destroy, controller: :photos, as: :photo
        end
        resources :meetings, only: [] do
          post '/documents/upload', action: :upload, controller: :documents
          delete '/documents/:id', action: :destroy, controller: :documents, as: :document
        end
      end
      # ╰─ End of AJAX Accesible URL's / Path's

      resources :users

      resource :dashboard, only: [:show]

      resources :organizations, only: [:show, :new, :create, :index]

      resources :neighborhoods, only: [:show, :new, :create, :index, :update, :edit] do
        resources :works, only: [:show, :new, :create, :index, :update, :edit]
        resources :meetings, only: [:show, :new, :create, :index, :update, :edit]
        resource :agreement, only: [ :show, :new, :create,:edit, :update]
      end
    end
  # ╰─ End of Private Accesible URL's / Path's
  end
end
