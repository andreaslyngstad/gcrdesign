class DataFile < ActiveRecord::Base
  has_attached_file :photo, :styles => { :small => "75x75>" }
                    
  validates_attachment_presence :photo, :message => "Du glemte å laste opp bildet"
  
  
end
