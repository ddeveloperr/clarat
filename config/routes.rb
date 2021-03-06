Clarat::Application.routes.draw do
  # Sitemap path
  mount DynamicSitemaps::Engine => '/sitemaps/'

  localized do
    # unscoped static pages
    root to: 'pages#section_forward'
    get '/404' => 'pages#not_found'

    scope ':section', section: /family|refugees/ do
      root to: 'pages#home', as: 'home'
      # scoped static pages
      get 'ueber-uns' => 'pages#about', as: 'about'
      get 'haeufige-fragen' => 'pages#faq', as: 'faq'
      get 'impressum' => 'pages#impressum', as: 'impressum'
      get 'rechtliche-hinweise' => 'pages#agb', as: 'agb'
      get 'datenschutzhinweise' => 'pages#privacy', as: 'privacy'

      # RESTful resources
      resources :offers, only: [:index, :show]
      resources :organizations, only: [:show]
      resources :contacts, only: [:new, :create, :index]

      # Previews
      get 'preview/offers/:id' => 'previews#show_offer'
      get 'preview/organizations/:id' => 'previews#show_organization'

      # Email overviews
      get 'emails/:id/offers' => 'emails#offers_index', as: 'emails_offers'
    end

    # unscoped to scoped forwards
    get 'offers/:id' => 'offers#section_forward', as: :unscoped_offer
    get 'organizations/:id' => 'organizations#section_forward',
        as: :unscoped_orga
    get 'ueber-uns' => 'pages#section_forward'
    get 'haeufige-fragen' => 'pages#section_forward'
    get 'impressum' => 'pages#section_forward'
    get 'rechtliche-hinweise' => 'pages#section_forward'
    get 'datenschutzhinweise' => 'pages#section_forward'

    # unscoped RESTful resources (only POST and non-HTML GET)
    resources :update_requests, only: [:new, :create]
    resources :search_locations, only: [:show]
    resources :subscriptions, only: [:new, :create]
    resources :definitions, only: [:show]

    # non-REST routes
    get 'emails/:id/subscribe/:security_code' => 'emails#subscribe',
        as: 'subscribe'
    get 'emails/:id/unsubscribe/:security_code' => 'emails#unsubscribe',
        as: 'unsubscribe'

    # All other localized paths => localized 404
    match '*path', to: 'pages#not_found', via: :all
  end

  # Unlocalized unknown paths are forwarded to the German 404
  match '*path', to: 'pages#not_found', via: :all
end
