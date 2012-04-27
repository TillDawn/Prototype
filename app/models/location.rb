class Location
  include Mongoid::Document
  include Mongoid::Timestamp
  include Mongoid::Versioning
  include Geocoder::Model::Mongoid
  
  reverse_geocoded_by :coordinates              # can also be an IP address
  after_validation :reverse_geocode
  
  embedded_in :locatable, :polymorphic => true
  
  field :coordinates, :type => Array
  field :address
  
end