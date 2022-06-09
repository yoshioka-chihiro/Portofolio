Rails.application.routes.draw do
  namespace :admin do
    get 'end_users/index'
    get 'end_users/show'
    get 'end_users/edit'
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :end_user, skip: [:passwords], path: :me, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root to: 'public/homes#top'

  scope module: :public do

    get 'about' => 'public/homes#about'
    resources :diaries, only:[:new, :index, :show, :edit] do
      resources :favorites, only: [:create, :destroy]
    end

    resources :end_users, only:[:show, :edit, :update, :index] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end

    get 'meal_details/show'

    resources :foods, only:[:index, :show]
    resources :meals, only:[:index, :show, :edit, :update, :create, :destroy]
    resources :meal_details, only:[:index, :create, :update, :destroy]
    resources :weights, only:[:index, :edit]

    patch 'end_users/:id/withdraw' => 'end_users#withdraw'
    get 'end_users/unsubscribe' => 'end_users#unsubscribe'


  end

  namespace :admin do
    get '/' => 'homes#top'
    resources :diary_comments, only:[:index, :show, :edit]
    resources :foods, only:[:index, :show, :new, :edit, :create, :update, :destroy]
    resources :end_users, only:[:index, :show, :edit, :update]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
