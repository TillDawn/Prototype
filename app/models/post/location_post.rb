class LocationPost
  include Geocoder::Model::Mongoid
  field :address
  field :coordinates, :type => Array
  
  geocoded_by :address               # can also be an IP address
  after_validation :geocode  
  
end
