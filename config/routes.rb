Rails.application.routes.draw do
  # デバイス用のルーティング
  devise_for :users
  # ルートパス
  root 'museums#new'
  get '/about' => 'homes#about'
  # ユーザーのルーティング
  # relationを入れ子構造に
  get 'users/sort' => 'users#sort'
  resources :users, only:[:index, :show, :edit, :update] do
    resources :relations, only:[:create, :destroy]
  end
  put '/users/:id/withdraw' => 'users#withdraw', as: 'user_withdraw'
  put '/users/:id/back' => 'users#back', as: 'user_back'

  get 'museums/sort' => 'museums#sort'
  resources :museums do
    resources :posts, only:[:create, :edit, :update, :destroy] do
      resources :favorites, only:[:create, :destroy]
    end
    resources :recommends, only:[:create, :destroy]
    resources :visits, only:[:create, :destroy]
  end
  get 'map' => 'museums#map'

  resources :genres, only:[:create, :index, :destroy]

  resources :forums, only:[:create, :index, :show, :destroy] do
    resources :forum_posts, only:[:create]
  end
  get 'forums/:id/chat' => 'forums#chat', as: 'forum_chat'
  post 'forums/:id/lock' => 'forums#lock', as: 'forum_lock'

  get 'search' => 'searches#search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
