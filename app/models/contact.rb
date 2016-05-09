class Contact < ActiveRecord::Base
#____________________________________________________________________________________________________________________________________________  


  validates :name,                 presence:         true,        
                                               
                                     length:         { maximum:           100,                                              
               
                                      :if =>         :name? }

#____________________________________________________________________________________________________________________________________________


  #validates :surname,              presence:         true,        
                                               
  #                                   length:         { maximum:           100,                                              
               
  #                                    :if =>         :surname? }

#____________________________________________________________________________________________________________________________________________


  # validates_inclusion_of :own_gender, in: [true, false]
  validates :own_gender,           inclusion: { :in => ['Мужской', 'Женский'] }

#____________________________________________________________________________________________________________________________________________


  validates :search_for_gender,    inclusion: { :in => ['Мужчины', 'Женщины', 'Оба пола'] }

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
end

   

