Rails.application.routes.draw do

  # TSE lookup utility (Technical Something Expert) primarily for internal use.
  get 'tse' => 'tse#index'
  namespace :tse do
    resources :tse_categories, path: :categories
    resources :tse_contacts, path: :contacts
    resources :tse_technologies, path: :technologies
    resources :tse_domains, path: :domains
    resources :tse_regions, path: :regions
    get 'admin' => 'admin#index'
    namespace :admin do
      resources :tse_categories, path: :categories
      resources :tse_contacts, path: :contacts
      resources :tse_technologies, path: :technologies
      resources :tse_domains, path: :domains
      resources :tse_regions, path: :regions
    end
  end

  get 'training_calendar/show'

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  # Logins for admins, etc.
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Old CMS using ActiveAdmin, still accessible at /admin
  ActiveAdmin.routes(self)

  # New CMS, accessible at /cms
  get '/cms' => 'cms#index', as: :cms_root
  namespace :cms do
    resources :available_locales, only: :show do
      resources :news_articles
      resources :slides
      (AvailableLocale.translatables - ["LandingPage", "Event", "TrainingContentPage"]).each do |t|
        resources t.underscore.pluralize.to_sym
      end
      resources :landing_pages do
        collection do
          get :originated
        end
      end
      resources :training_content_pages do
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

  # EMEA portal
  get '/lp/emeaportal' => redirect('/emea')
  get '/emea' => 'emea_pages#index', as: :emea_root

  namespace :emea do
    get 'admin' => 'admin#index'
    namespace :admin do
      resources :emea_employee_contacts, path: "employee_contacts"
      resources :emea_pages, path: "pages" do
        resources :emea_page_resources, path: "resources"
      end
      resources :channels,
        :channel_countries,
        :channel_managers,
        :channel_country_managers,
        :distributors
      resources :users, only: [:index, :show, :destroy]
      post 'update_invitation_code'
      patch 'update_invitation_code'
    end
    resources :channels, :channel_countries, only: :index, defaults: { format: 'json' }
    get "channel/:channel_id/country/:channel_country_id/managers(.:format)" => 'channel_managers#search', defaults: { format: 'json' }

    get "departments(.:format)" => 'employee_contacts#departments', defaults: { format: 'json' }
    get "department/:department_id/job_functions(.:format)" => 'employee_contacts#job_functions', defaults: { format: 'json' }
    get "department/:department_id/job_function/:job_function_id/contacts(.:format)" => 'employee_contacts#contacts', defaults: { format: 'json' }

    get "distributors/countries(.:format)" => 'distributors#countries', defaults: { format: 'json' }
    get "distributors/brands(.:format)" => 'distributors#brands', defaults: { format: 'json' }
    get "distributors/country/:country_id/brand/:brand_id/distributors(.:format)" => 'distributors#distributors', defaults: { format: 'json' }
  end
  resources :emea_pages, path: 'emea', only: [:index, :show]

  # Main site routes
  resources :brands, only: :show do
    member do
      get :softwares
    end
    resources :products, only: [:index, :show]
  end
  resources :vertical_markets, path: 'applications', only: [:index, :show] do
    resources :reference_systems, path: 'solutions', only: :show
    resources :case_studies, only: [:index, :show ] # "show" = old route which now forwards to the non-scoped variety
  end
  resources :case_studies, only: [:index, :show]
  resources :events, only: [:index, :show] do
    collection do
      get :recent
    end
  end

  get 'new_products' => 'new_products#index', as: :new_products
  get '/lp/new-products', to: redirect('/new_products')
  get 'new-products', to: redirect('/new_products')

  get 'lp/:id(/:random)' => 'landing_pages#show', as: :landing_page
  get 'ep/:id(/:embed)' => 'landing_pages#show', defaults: { embed: 'true' }
  resources :leads, path: 'plan/help', only: [:new, :create]
  resources :news_articles, path: 'news', only: [:index, :show]
  resources :artists, only: [:index, :show]
  resources :products, only: [:index, :show]

  # Cinema Calculator
  get '/cinema/calculator' => 'calculators#cinema'

  # Consultant Portal
  get '/consultants/software(.:format)' => 'consultants#software', defaults: { format: 'json' }
  get '/consultant' => 'consultants#index', as: :consultant_portal
  get '/consultant-portal', to: redirect('/consultant')
  get '/consultants', to: redirect('/consultant')

  # Service Site
  get '/service' => 'service#index', as: :service
  get '/service_centers/login' => 'service_centers#login', as: :service_center_login
  resources :service_centers, only: [:index, :new, :create]
  post '/service' => 'service#create_contact_message', as: :service_create_contact_message

  # Training site
  get '/training' => 'training_content_pages#show'
  get '/training/sso' => 'training_courses#sso'
  # get '/training/courses' => 'training_courses#index'
  get '/training/calendar' => 'training_calendar#index'
  resources :training_content_pages, path: 'training', only: :show

  # Resource library (local resources on our site)
  get '/resource-library/:id' => 'resources#show', as: :resource_permalink

  # The Widen DAM
  resources :media_library_access_requests, only: [:new, :create]
  get 'media_library' => "media_library#index"
  get 'medialibrary', to: redirect('/media_library')
  get 'media-library', to: redirect('/media_library')

  # HEF
  get 'finance' => "finance#index"
  get 'financing', to: redirect('/finance')
  get 'hef', to: redirect('/finance')
  get 'equipment-financing', to: redirect('/finance')
  get 'harman-equipment-financing', to: redirect('/finance')

  # Akamai sure route test
  get '/sureroute-test-object(.:format)' => 'main#sureroute', as: :sureroute_test_object

  # The usual stuff

  # Contacts
  get "/contacts", to: "landing_pages#contacts_home"
  get "/contacts/solutions", to: "landing_pages#contacts_solutions"
  get "/contacts/brands", to: "landing_pages#brand_contacts"
  get "/contacts/channel", to: "landing_pages#contacts_channel_map"
  get "/contacts/:search", to: "contacts#show"
  get "/contacts/:search/:chosen_contacts_path", to: "contacts#show"

  get '/thankyou' => 'landing_pages#thankyou', as: :thankyou # Thank you page after leadgen form
  get '/thanks' => 'landing_pages#thanks', as: :thanks # Generic thanks page
  get '/privacy_policy', to: redirect('https://www.harman.com/privacy-policy'), as: :privacy_policy
  get '/terms_of_use', to: redirect('https://www.harman.com/terms-use'), as: :terms_of_use
  get '/sitemap(.:format)' => 'main#sitemap', as: :sitemap

  # New Products
  get "/new-products", to: "landing_pages#show", id: "new-products"

  # Search
  get '/search' => 'search#search', as: :search

  # Old paperclip attachment redirects
  get 'system/:model/:attachment/:id_and_timestamp/:basename.:extension' => 'paperclips#redirects'
  get 'system/:model/:attachment/:id1/:id2/:id3/:style/:basename.:extension' => 'paperclips#redirects'

  # Social media
  get '/facebook', to: redirect('https://www.facebook.com/HarmanInt?_rdr=p')
  get '/twitter', to: redirect('https://twitter.com/Harman')
  get '/linkedin', to: redirect('https://www.linkedin.com/company/harman-international')
  get '/youtube', to: redirect('https://www.youtube.com/user/HarmanIntl')
  get '/pinterest', to: redirect('https://www.pinterest.com/harmanint/')
  get '/google', to: redirect('https://plus.google.com/+HarmanIntl/videos')

  # Temporary landing page
  get '/jblmasterclass' => 'landing_pages#jblmasterclass'

  root to: 'main#index'
  get "*shorturl" => "shorturls#show", as: :shorturl

end
