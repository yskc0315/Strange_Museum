Rails.application.routes.draw do
  # デバイス用のルーティング
  devise_for :users
  # ルートパス
  root 'homes#top'
  get '/about' => 'homes#about'
  # ユーザーのルーティング
  # relationを入れ子構造に
  resources :users, only:[:index, :show, :edit, :update] do
    resources :relations, only:[:create, :destroy]
  end
  put '/users/:id/withdraw' => 'users#withdraw', as: 'user_withdraw'

  get 'museums/sort' => 'museums#sort'
  resources :museums do
    resources :posts, only:[:create, :edit, :update, :destroy] do
      resources :favorites, only:[:create, :destroy]
    end
    resources :recommends, only:[:create, :destroy]
    resources :visits, only:[:create, :destroy]
  end

  resources :genres, only:[:create, :index, :destroy]

  resources :forums, only:[:create, :index, :show, :destroy] do
    resources :forum_posts, only:[:create]
  end
  post 'forum/:id/lock' => 'forums#lock', as: 'forum_lock'

  get 'search' => 'searches#search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
