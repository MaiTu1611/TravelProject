Rails.application.routes.draw do
  resources :travels do
    resources :tours
  end
  resources :tours
  resources :send_mails
  	get 'errors/not_found'
  	get 'errors/internal_server_error'
	# match '/404', to: 'errors#not_found', :via => :all 
	# match '/500', to: 'errors#internal_server_error', :via => :all
	# match '*path', to: 'application#catch_404', via: :all
  	resources :questions do
 		resources :answers
 	end
  	get 'welcome/index'
  	devise_for :users , controllers: { confirmations: 'confirmations' }
  	resources :articles
  	get 'articles/downloadFile/:id', to:'articles#downloadFile', as: 'article_download_file'
  	resources :users
  	get 'user/update_password'=>'users#update_password', as: 'user_update_password'
  	get 'user/index_update_password'=>'users#index_update_password', as: 'user_index_update_password'
    get 'user/send_mail'=>'users#send_mail', as: 'user_send_mail'
    get 'articles/delete_tour/:id_destroy_tour'=>'articles#destroy_tour', as: 'destroy_tour'
  	root to: 'welcome#index'
  	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
