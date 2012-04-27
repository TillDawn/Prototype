class LocationPost < Post
  include Geocoder::Model::Mongoid
  
  field :address
  field :coordinates, :type => Array
  
  geocoded_by :address
  after_validation :geocode  
  
end
