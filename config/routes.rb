Rails.application.routes.draw do
  # 顧客用
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  # 管理者用
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

# 顧客用
root to: 'public/homes#top'
scope module: :public do
  resources :items do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: :create
    collection do
      get 'search'
    end
    resources :comments, only: [:create]
  end
  get 'customers/mypage'=>'customers#mypage'
  get 'customers/unsubscribe'=>'customers#unsubscribe'
  patch 'customers/withdraw'=>'customers#withdraw'
  resources :customers
end

# 管理者用
namespace :admin do
     resources :items
     resources :genres, only: [:new, :create]
     resources :customers
     resources :reviews, only: [:destroy]
   end

resources :records do
   resources :comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
