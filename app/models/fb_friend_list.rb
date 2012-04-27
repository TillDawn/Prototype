class FbFriendList
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :user
    
  field :data
end
