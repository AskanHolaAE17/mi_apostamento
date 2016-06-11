Rails.application.routes.draw do                

  match '/',                               to: 'main_pages#index',                                  via: 'get'  
  post  '/',                               to: 'main_pages#index'           
  
  match 'info/:msg',                       to: 'order_info_pages#show',                             via: 'get'  
  post  'info/:msg',                       to: 'order_info_pages#show'                                  
  
  match 'infos/:msg/:to_test_2',            to: 'order_info_pages#show',                             via: 'get'  
  post  'infos/:msg/:to_test_2',            to: 'order_info_pages#show'                                
  
  post  '/orders',                         to: 'orders#create'                  # for OrderForm works (path for creating new order)
  
  match  '/i_have_payed/:details',         to: 'orders#b_test_for_get_contacts_after_pay',          via: 'get'  
  post  '/i_have_payed/:details',          to: 'orders#b_test_for_get_contacts_after_pay'
  
  
  
  post  '/test/:test_url_encoded',         to: 'tests#load_page'
  match '/test/:test_url_encoded',         to: 'tests#load_page',                                   via: 'get'    

  match '/much_form/:order_info',          to: 'contacts#more_info_form',                           via: 'get'        
  post  '/contacts',                       to: 'contacts#create'                # for MoreContactsForm works (path for creating new contact)  
  match '/contacts/:details',              to: 'contacts#show',                                     via: 'get'      
  
                                               
  
  match '/articles/:translit',             to: 'main_pages#index',                                   via: 'get'  # for set current Article & load Articles menu    
    
  root 'main_pages#index'
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)    
    
  match "*path",                           to: 'main_pages#index',                                  via: 'get'
end
