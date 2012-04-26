class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  devise :omniauthable

  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  field :first_name
  field :last_name
  field :fb_link 
  
  field :image_url
  field :fb_uid
  field :fb_token
  
  
  validates_presence_of :email
  validates_uniqueness_of :email, :fb_uid
  
  set_callback(:create, :after) do |document|
    document.create_fb_friend_list(:data => get_fb_friend_list)
  end
  
  def get_fb_friend_list  JSON.parse(Typhoeus::Request.get("https://graph.facebook.com/#{fb_uid}/friends?access_token=#{fb_token}").body)["data"]
  end
  
  # def get_linked_profiles
  #   if fb_friend_list.nil?
  #     []
  #   else
  #     Profile.where(:fb_uid.in => fb_friend_list.data.collect{|i| i["id"]})
  #   end
  # end

  def fb_user
    FbGraph::User.me(fb_token)
  end
  
  class << self
    
    def find_for_facebook_oauth(access_token, signed_in_resource=nil)
      puts "[FB ACCESS TOKEN]: " + access_token.inspect
      data = access_token.extra.raw_info
      info = access_token.info
      location = (data.location || "")
      hometown = (data.hometown || "")
      fb_uid = access_token.uid
      fb_token = access_token.credentials.token
      puts "[FB USER DATA]: " + data.inspect
      if user = User.where(:fb_uid => fb_uid).first
        user.update_attribute(:access_token, access_token.token)
      else # Create a user with a stub password. 
        user = User.new(:email => data.email, :password => Devise.friendly_token[0,20], :first_name => data.first_name, :last_name => data.last_name,  :fb_uid => fb_uid, :image_url => info.image, :fb_token => fb_token)
        user.save!
      end
    end
    
    def new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"]
        end
      end
    end
    
  end
  
end
