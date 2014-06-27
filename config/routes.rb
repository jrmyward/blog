Blog::Application.routes.draw do

  resources :list_subscribers

  devise_for :users, :skip => [:sessions, :registrations]
  as :user do
    get 'signin' => 'devise/sessions#new', as: :new_user_session
    post 'signin' => 'devise/sessions#create', as: :user_session
    delete 'signout' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  scope 'a', module: 'admin', as: 'admin' do
    scope "blog" do
      resources :posts, except: [:show]
    end
    resources :comments, except: [:create, :new] do
      collection do
        delete 'destroy-batch' => "comments#destroy_batch", as: "destroy_batch"
      end
      member do
        put 'approve'
        put 'reject'
      end
    end
    resources :users, except: [:index, :new, :create, :destroy]
    get 'dashboard' => 'users#dashboard', as: 'root'
  end

  scope "/settings" do

  end

  get '/dashboard' => 'admin/users#dashboard', as: :user_root

  scope "blog" do
    get 'tags/:tag', to: 'posts#index', as: :tag
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:create, :new]
    end
  end

  resources :subscribers, controller: 'list_subscribers', only: [:create, :new] do
    collection do
      post 'confirm'
      get 'confirm' # used by MailChimp to confirm
    end
  end

  # Static content
  get 'about' => 'content#about'
  get 'projects' => 'content#projects'
  get 'resume' => 'content#resume'

  # You can have the root of your site routed with "root"
  root :to => "content#index"

end








