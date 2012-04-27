class LocationHistory
  include Mongoid::Document
  
  belongs_to :user
  embeds_many :locations, :as => :locatable
  
end
