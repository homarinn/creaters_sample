Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
  }

  devise_scope :user do
    # 新規登録
    get "sign_up", to: "users/registrations#new"
    post "sign_up", to: "users/registrations#create"

    # アカウント設定編集
    get "account_setting", to: "users/registrations#edit"
    patch "account_setting", to: "users/registrations#update"

    # アカウント削除
    delete "delete_account", to: "users/registrations#destroy"

    # ログイン及びログアウト
    get "sign_in", to: "users/sessions#new"
    get "sign_out", to: "users/sessions#sign_out"
    delete "sign_out", to: "users/sessions#destroy"
  end

end
