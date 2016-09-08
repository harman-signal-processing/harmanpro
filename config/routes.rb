Rails.application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  # Logins for admins, etc.
  devise_for :admin_users, skip: [:registrations]
  as :admin_user do
    get 'admin_users/edit' => 'admin_users/registrations#edit', as: :edit_admin_user_registration
    patch 'admin_users' => 'admin_users/registrations#update', as: :admin_user_registration
  end

  # Old CMS using ActiveAdmin, still accessible at /admin
  ActiveAdmin.routes(self)

  # New CMS, accessible at /cms
  get '/cms' => 'cms#index', as: :cms_root
  namespace :cms do
    resources :available_locales, only: :show do
      resources :news_articles
      resources :slides
      (AvailableLocale.translatables - ["LandingPage", "Event"]).each do |t|
        resources t.underscore.pluralize.to_sym
      end
      resources :landing_pages do
        collection do
          get :originated
        end
      end
      resources :events do
        collection do
          get :local
        end
      end
      resources :menu_items do
        collection do
          put :add_defaults
        end
      end
      resources :artists
      member do
        patch :store_link
        patch :blog_link
        get :edit_consultants
        post :update_consultants
      end
    end
  end

  # Main site routes
  resources :brands, only: :show do
    member do
      get :softwares
    end
    resources :products, only: [:index, :show]
  end
  resources :vertical_markets, path: 'applications', only: :show do
    resources :reference_systems, path: 'solutions', only: :show
    resources :case_studies, only: :show
  end
  resources :events, only: [:index, :show] do
    collection do
      get :recent
    end
  end
  resources :landing_pages, path: 'lp', only: :show
  resources :leads, path: 'plan/help', only: [:new, :create]
  resources :venues, only: :index
  resources :news_articles, path: 'news', only: [:index, :show]
  resources :artists, only: [:index, :show]

  # Consultant Portal
  get '/consultants/software(.:format)' => 'consultants#software', defaults: { format: 'json' }
  get '/consultant' => 'consultants#index', as: :consultant_portal
  get '/consultant-portal', to: redirect('/consultant')
  get '/consultants', to: redirect('/consultant')

  # Service Site
  get '/service' => 'service#index', as: :service
  get '/service_centers/login' => 'service_centers#login', as: :service_center_login
  resources :service_centers, only: [:index, :new, :create]

  # Training site
  get '/training' => 'landing_pages#training'

  # Resource library (local resources on our site)
  get '/resource-library/:id' => 'resources#show', as: :resource_permalink

  # The Widen DAM
  resources :media_library_access_requests, only: [:new, :create]
  get 'media_library' => "media_library#index"
  get 'medialibrary', to: redirect('/media_library')
  get 'media-library', to: redirect('/media_library')

  # Akamai sure route test
  get '/sureroute-test-object(.:format)' => 'main#sureroute', as: :sureroute_test_object

  # The usual stuff
  get '/contacts' => 'landing_pages#contacts'
  get '/thankyou' => 'landing_pages#thankyou', as: :thankyou # Thank you page after leadgen form
  get '/thanks' => 'landing_pages#thanks', as: :thanks # Generic thanks page
  get '/privacy_policy' => 'landing_pages#privacy_policy', as: :privacy_policy
  get '/terms_of_use' => 'landing_pages#terms_of_use', as: :terms_of_use
  get '/sitemap(.:format)' => 'main#sitemap', as: :sitemap

  root to: 'main#index'

end
