class MergePost < Post
  
  belongs_to :merge_user, :class_name => 'User', :inverse_of => nil
  
end