Rails.application.routes.draw do
  root 'home#top'
  get 'home/top', to: "home#top"
  get 'home/novels', to: "home#novels"
  get 'home/illustrations', to: "home#illustrations"
  get 'home/comics', to: "home#comics"
  get 'home/help', to: "home#help"

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
  }

  devise_scope :user do
    # 新規登録
    get :sign_up, to: "users/registrations#new"
    post :sign_up, to: "users/registrations#create"

    # アカウント設定編集
    get :account_setting, to: "users/registrations#edit"
    patch :account_setting, to: "users/registrations#update"

    # アカウント削除
    delete :delete_account, to: "users/registrations#destroy"

    # ログイン及びログアウト
    get :sign_in, to: "users/sessions#new"
    delete :sign_out, to: "users/sessions#destroy"
  end

  # ユーザー関連
  resources :users, except: [:create, :delete] do
    collection do
      post :search
    end
  end

  namespace :manage do
    get :mypage, to: "users#mypage"
    %w(novel illustration comic).each do |work|
      resources work.pluralize.to_sym, except: :index do
        collection do
          get "draft_index", as: "draft"
          get "posted_index", as: "posted"
        end
        member do
          match "post", to: "#{work}s#post", via: [:get, :patch], as: "post"
          post :status_change
        end
      end
      scope module: :series do
        resources "#{work}_series".to_sym, except: :index do
          member do
            match "next_work_post", to: "#{work}_series#next_work_post", via: [:get, :patch], as: "next_work_post"
            post :status_change
          end
        end
      end
    end
  end

  # シリーズ関連
  # -------------------------------------------------
  scope module: :series do
    resources :novel_series, only: [:index, :show] do
      collection do
        post :search
      end
    end

    resources :illustration_series, only: [:index, :show] do
      collection do
        post :search
      end
    end

    resources :comic_series, only: [:index, :show] do
      collection do
        post :search
      end
    end
  end
  # -------------------------------------------------

  # 作品単体
  # -------------------------------------------------
  resources :novels, only: [:index, :show] do
    collection do
      post :search
    end
  end

  resources :illustrations, only: [:index, :show] do
    collection do
      post :search
    end
  end

  resources :comics, only: [:index, :show] do
    collection do
      post :search
    end
  end
  # -------------------------------------------------

  # メッセージ機能(未作成機能)
  # ---------------------------------------------------------------------------------------
  scope module: :message_rooms do
    # DM
    resources :direct_message_rooms, only: [:index, :create, :destroy] do
      resources :messages, only: [:index, :create]
      namespace :api do
        resources :messages, only: :index, defaults: { format: 'json' }
      end
    end

  #   # プロジェクトチーム
  #   resources :group_message_rooms, only: [:index, :new, :show, :create, :edit, :update, :destroy] do
  #     resources :messages, only: [:index, :create]
  #     namespace :api do
  #       resources :messages, only: :index, defaults: { format: 'json' }
  #     end
  #   end
  end
  # ---------------------------------------------------------------------------------------

  # 詳細検索
  # ---------------------------------------------------------------------------------------
  get :search, to: 'search#index'
  post :search, to: 'search#index'
  # ---------------------------------------------------------------------------------------

  # genre
  # ---------------------------------------------------------------------------------------
  Genre.all.each do |genre|
    get genre.path_name, to: "genres#index"
  end
end
