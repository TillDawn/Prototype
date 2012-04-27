class Stream
  include Mongoid::Document
  
  belongs_to :user
  
  embeds_many :posts
  
end
