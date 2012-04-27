class TextPost < Post
  field :body
  
  validates_presence_of :body

end
