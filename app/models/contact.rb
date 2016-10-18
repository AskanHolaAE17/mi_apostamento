class Contact < ActiveRecord::Base
  
  belongs_to        :user 
  has_one           :order
   
  has_attached_file :image


#____________________________________________________________________________________________________________________________________________  
#DEF
  
  #secret_answer
  def checkbox_has_2values
    checkbox_count =  self.secret_question.count(',')
    unless checkbox_count == 1
      errors.add(:secret_question, 'secret_answer_error')
    end
  end

#DEF-end   
#____________________________________________________________________________________________________________________________________________  


  validates :name,                   presence:         true,        
                                               
                                     length:         { maximum:           100,                                              
               
                                      :if =>         :name? }

#____________________________________________________________________________________________________________________________________________


  validates :surname,                presence:         true,        
                                               
                                     length:         { maximum:           100,                                              
               
                                      :if =>         :surname? }

#____________________________________________________________________________________________________________________________________________


  validates :city,                   presence:         true,        
                                               
                                     length:         { maximum:           100,                                              
               
                                      :if =>         :city? }

#____________________________________________________________________________________________________________________________________________


  validates :country,                presence:         true,        
                                               
                                     length:         { maximum:           100,                                              
               
                                      :if =>         :country? }

#____________________________________________________________________________________________________________________________________________


  validates :birthday,               presence:         true,        
                                               
                                     length:         { maximum:           100,                                              
               
                                      :if =>         :birthday? }

#____________________________________________________________________________________________________________________________________________


  validates :own_gender,             presence: true 

#____________________________________________________________________________________________________________________________________________


  validates :search_for_gender,      presence: true 

#____________________________________________________________________________________________________________________________________________


  validates :about_info,             presence:         true,        
                                               
                                     length:         { maximum:           10000,                                              
               
                                      :if =>         :about_info? }
                                      
#____________________________________________________________________________________________________________________________________________


  validates :deep_info,              presence:         true,        
                                               
                                     length:         { maximum:           10000,                                              
               
                                      :if =>         :deep_info? }

#____________________________________________________________________________________________________________________________________________  


  validates :looking_for,            presence:         true,        
                                               
                                     length:         { maximum:           10000,                                              
               
                                      :if =>         :looking_for? }

#____________________________________________________________________________________________________________________________________________  


  ### ATTACHED IMAGE
  
  #has_attached_file :image,
  #  :storage => :dropbox,
  #  :dropbox_credentials => Rails.root.join("config/dropbox.yml")
    #,
    #:dropbox_options => {...}
      
 #:styles => { :medium => "300x300" , :thumb => "100x100>"},    
 #:dropbox_options => {       
 #:path => proc { |style| "#{style}/#{id}_#{picture.original_filename}"},       :unique_filename => true   
 # }
  
  validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
                       size: { in: 0..6000.kilobytes }
  validates :image, attachment_presence: true
   
#____________________________________________________________________________________________________________________________________________


  validates :secret_question,              presence:         true
  validate  :checkbox_has_2values,         if:               :secret_question?                 

#____________________________________________________________________________________________________________________________________________    


  validates :secret_answer_1,              presence:         true

#____________________________________________________________________________________________________________________________________________    


  validates :secret_answer_2,              presence:         true

#____________________________________________________________________________________________________________________________________________    

end

   

