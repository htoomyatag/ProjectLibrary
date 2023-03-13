Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :users
  resources :documents
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'documents#my_document'
  get 'my_document/:id' => 'documents#my_document', as: 'my_document'
  post 'copy_document' => 'documents#copy_document', as: 'copy_document'
  get 'contact_admin' => 'users#contact_admin', as: 'contact_admin'
end
