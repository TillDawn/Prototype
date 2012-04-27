class ImagePost < Post
  include Mongoid::Paperclip
  
  has_mongoid_attached_file :image,
    :path           => ':attachment/:id/:style.:extension',
      :storage        => :s3,
      :url            => ':s3_alias_url',
      :bucket         => 'tilldawn-demo',
      :s3_credentials => File.join(Rails.root, 'config', 's3.yml'),
      :styles => {
        :original => ['1920x1680>', :jpg],
        :small    => ['100x100#',   :jpg],
        :medium   => ['250x250',    :jpg],
        :large    => ['500x500>',   :jpg]
      },
      :convert_options => { :all => '-background black -flatten +matte' }
  validates_presence_of :image
end
