Rails.application.routes.draw do                


  devise_for :admin_users, ActiveAdmin::Devise.config
  match '/',                               to: 'main_pages#index',                                  via: 'get'  
  post  '/',                               to: 'main_pages#index'           

  match '/articles/:translit',             to: 'main_pages#index',                                  via: 'get'  # for set current Article & load Articles menu      

  
  match 'info/:msg',                       to: 'order_info_pages#show',                             via: 'get'  
  post  'info/:msg',                       to: 'order_info_pages#show'                                  
  
  match 'room_info_messages/:msg',         to: 'room_nonverbally_info_pages#show',                  via: 'get'  
  post  'room_info_message/:msg',          to: 'room_verbally_info_pages#show'                                  
  
  match 'room_info/:msg',                  to: 'room_nonverbally_info_pages#show',                  via: 'get'    
  
  
  
  match 'infos/:msg/:to_test_2',           to: 'order_info_pages#show',                             via: 'get'  
  post  'infos/:msg/:to_test_2',           to: 'order_info_pages#show'                                 
  
  post  '/orders',                         to: 'orders#create'                  # for OrderForm works (path for creating new order)
  match 'orders/:url_details',             to: 'orders#payed',                                      via: 'get'    
  
  
  match  '/i_have_payed_consult/:details', to: 'consults#e_get_consults_after_pay',                 via: 'get'  
  post  '/i_have_payed_consult/:details',  to: 'consults#e_get_consults_after_pay'
  #match  '/i_have_payed_test/:details',    to: 'orders#b_get_contacts_after_pay',                   via: 'get'  
  #post  '/i_have_payed_test/:details',     to: 'orders#b_get_contacts_after_pay'  



  #TEST_LEVEL___________________________________________________________________
  #testo
  #tests
  #testo_more
  
  match '/testo/:test_encrypted',          to: 'test_levels#level_qws_signal',                      via: 'get'          
  post  '/testo/:test_encrypted',          to: 'test_levels#level_qws_signal'
    
  post  '/te_s_le_ar',                     to: 'test_levels#signal_level_array_save'                     
  
  match '/tests/:test_encrypted',          to: 'test_levels#level_qws_body',                        via: 'get'      
  post  '/tests/:test_encrypted',          to: 'test_levels#level_qws_body'
  
  match '/testo_more/:details_encoded',    to: 'test_levels#level_qws_signal_more',                 via: 'get'          
  post  '/testo_more/:details_encoded',    to: 'test_levels#level_qws_signal_more'  
  
  post  '/te_s_le_mo_ar',                  to: 'test_levels#signal_level_more_array_save'                     
  
  
  
  #TEST_LEVEL_STRUCT_BETWEEN____________________________________________________      


  match '/testo_full/:details_encoded',    to: 'tests_level_struct_betweens#instruction_before_level_body',   via: 'get'          
  post  '/testo_full/:details_encoded',    to: 'test_levels#instruction_before_level_body'    
  
  
  #TEST_STRUCT__________________________________________________________________
  #testo_s
  #tests_s
  #tests_more
  
  match '/testo_s/:test_encrypted',        to: 'test_structs#struct_qws_signal',                    via: 'get'          
  post  '/testo_s/:test_encrypted',        to: 'test_structs#struct_qws_signal'
    
  post  '/te_s_st_ar',                     to: 'test_structs#signal_struct_array_save'                     
  
  match '/tests_s/:test_encrypted',        to: 'test_structs#struct_qws_body',                      via: 'get'      
  post  '/tests_s/:test_encrypted',        to: 'test_structs#struct_qws_body'
  
  match '/tests_more/:details_encoded',    to: 'test_structs#struct_qws_signal_more',               via: 'get'          
  post  '/tests_more/:details_encoded',    to: 'test_structs#struct_qws_signal_more'  
  
  post  '/te_s_st_mo_ar',                  to: 'test_structs#signal_struct_more_array_save'           
          
  
  match '/tests_gender/:details_encoded',  to: 'test_structs#form_gender_if_il_struct',             via: 'get'          
  post  '/tests_gender/:details_encoded',  to: 'test_structs#form_gender_if_il_struct'    
  
  post  '/tests_gender_save',              to: 'test_structs#save_gender_if_il_struct'  
  
  #TESTS_END____________________________________________________________________  
  
  
  
  match '/test/:test_encrypted',           to: 'tests#load_page',                                   via: 'get'        
  post  '/test/:test_encrypted',           to: 'tests#load_page'                                   



  match '/much_form/:order_info',          to: 'contacts#more_info_form',                           via: 'get'        
  post  '/much_form/:order_info',          to: 'contacts#more_info_form'  


  
  post  '/contacts',                       to: 'contacts#create'                # for MoreContactsForm works (path for creating new contact)  
  match '/contacts/:details',              to: 'contacts#show',                                     via: 'get'      

  match '/contacts-show/:details',         to: 'contacts#link_with_contacts',                       via: 'get'        


       
  
  post  '/consults',                       to: 'consults#create'                # for creating new contact
  
  
  
  match '/deactivate-contact/:deactive_params',    to: 'contacts#disable_contact_ask',              via: 'get'      
  match '/de-activate-contact/:deactive_params',   to: 'contacts#disable_contact',                  via: 'get'        
  post  '/de-activate-contact/:deactive_params',   to: 'contacts#disable_contact'  
  
  match '/show-contacts/:details',                 to: 'contacts#link_with_contacts_again',         via: 'get'          
  
  
            
  ## dannue_receive_obrabotanu  
  match 'receive/:details',                to: 'tests#qs',                                          via: 'get'
  
  
  #_____________________________________________________________________________
  
  
      
  match 'do_you_want_to_db/:details',      to: 'users#does_user_want_to_db',                        via: 'get'  
  match 'room_sent/:details',              to: 'users#room_url_without_added_to_base',              via: 'get'
  post  'room_sent/:details',              to: 'users#room_url_without_added_to_base',              via: 'get'          
  
      
  ## (User Loged In)
  ## ROOM 
  match 'room/:details',                   to: 'rooms#show',                                        via: 'get'      
  
  match 'room_see/:details',               to: 'rooms#any_room',                                    via: 'get'        
   
   
   
  #MESSAGE
  post  'message_new/:details',            to: 'messages#new'                                        
  match 'message_new/:details',            to: 'messages#new',                                      via: 'get'           
  
  post  'msg_new/:details',                to: 'messages#new'                                        
  match 'msg_new/:details',                to: 'messages#new',                                      via: 'get'             
  
  
  match 'messages/:details',               to: 'messages#show',                                     via: 'get'             
  match 'msg/:details',               to: 'messages#show',                                     via: 'get'               
  
  
  
  # FEEDBACKS SL
  post  'recommendations/:details',        to: 'feedbacks_structures_levels#show'                                          
  match 'recommendations/:details',        to: 'feedbacks_structures_levels#show',                  via: 'get'             
  
  post  'recommends/:details',        to: 'feedbacks_structures_levels#show'                                          
  match 'recommends/:details',        to: 'feedbacks_structures_levels#show',                  via: 'get'               
  
  #_____________________________________________________________________________
	

  # NAVIGATION MENU - ROOM
  # CONVERSATIONS

  post  'conversations/:details',          to: 'conversations#show'                                          
  match 'conversations/:details',          to: 'conversations#show',                                via: 'get'               	

#_____________________________________________________________________________	
  
    
  # NAVIGATION MENU - ROOM
  # REQUESTS
    
  post  'requests/:details',               to: 'requests_for_communications#show'                                          
  match 'requests/:details',               to: 'requests_for_communications#show',                  via: 'get'               
  
#_____________________________________________________________________________	
  
    
  # NAVIGATION MENU - ROOM
  # FEEDBACKS SHOW
    
  post  'feedbacks_show/:details',         to: 'show_feedback_requests#show'                                          
  match 'feedbacks_show/:details',         to: 'show_feedback_requests#show',                       via: 'get'               
  
  
  # FEEDBACKS OPEN
    
  post  'feedbacks_open/:details',         to: 'show_feedback_requests#open'                                          
  match 'feedbacks_open/:details',         to: 'show_feedback_requests#open',                       via: 'get'               
    
#________________________________________
  
  
  # NAVIGATION MENU - ROOM
  # SHOW/OFF IN BASE 
  
  
  # SHOW OFF

  post  'in_from_base/:details',                to: 'users#show_off_in_db'                                          
  match 'in_from_base/:details',                to: 'users#show_off_in_db',                                  via: 'get'                   
  
  ## OFF
    
  #post  'from_base/:details',              to: 'users#off_in_db'                                          
  #match 'from_base/:details',              to: 'users#off_in_db',                                   via: 'get'                 
  
    
  
  
    
  #CONSULT___________________________________________________________________

  match '/personal_consult',                 to: 'user_personal_consults#new',                                  via: 'get'
  post '/personal_consult',                  to: 'user_personal_consults#create'
  #resources :user_personal_consult



  
#_____________________________________________________________________________  
  
  
  
  resources :users do
    resources :requests_for_communications
    resources :show_feedback_requests
    resources :messages
  end  
  
  resources :conversations do
    resources :messages
  end    
  
    
  root 'main_pages#index'

  ActiveAdmin.routes(self)    
    
  match "*path",                           to: 'main_pages#index',                                  via: 'get'
  
end
