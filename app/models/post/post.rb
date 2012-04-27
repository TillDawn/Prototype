class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::TaggableWithContext
  taggable
  
  embedded_in :stream
  belongs_to :poster, :polymorphic => true, :inverse_of => nil
  
  field :poster_icon_url
  field :poster_name
  
end
