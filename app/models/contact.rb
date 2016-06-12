class Contact < ActiveRecord::Base

  has_attached_file :image

  #has_attached_file :image,
  #  :storage => :dropbox,
  #  :dropbox_credentials => Rails.root.join("config/dropbox.yml")
    #,
    #:dropbox_options => {...}
      
 #:styles => { :medium => "300x300" , :thumb => "100x100>"},    
 #:dropbox_options => {       
 #:path => proc { |style| "#{style}/#{id}_#{picture.original_filename}"},       :unique_filename => true   
 # }
  
  validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  validates :image, attachment_presence: true

  
    
#____________________________________________________________________________________________________________________________________________  


  validates :name,                 presence:         true,        
                                               
                                     length:         { maximum:           100,                                              
               
                                      :if =>         :name? }

#____________________________________________________________________________________________________________________________________________


  #validates :surname,              presence:         true,        
                                               
  #                                   length:         { maximum:           100,                                              
               
  #                                    :if =>         :surname? }

#____________________________________________________________________________________________________________________________________________


  validates :own_gender,           presence: true 

#____________________________________________________________________________________________________________________________________________


  validates :search_for_gender,    presence: true 

#____________________________________________________________________________________________________________________________________________


  validates :city,                 presence:         true,        
                                               
                                     length:         { maximum:           100,                                              
               
                                      :if =>         :city? }

#____________________________________________________________________________________________________________________________________________


  validates :country,              presence:         true,        
                                               
                                     length:         { maximum:           100,                                              
               
                                      :if =>         :country? }

#____________________________________________________________________________________________________________________________________________


  validates :birthday,             presence:         true,        
                                               
                                     length:         { maximum:           100,                                              
               
                                      :if =>         :birthday? }

#____________________________________________________________________________________________________________________________________________


  validates :about_info,           presence:         true,        
                                               
                                     length:         { maximum:           1000,                                              
               
                                      :if =>         :about_info? }

#____________________________________________________________________________________________________________________________________________


  #validates :image,           presence:         true
    
#____________________________________________________________________________________________________________________________________________  
end

   

