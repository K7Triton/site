class User < ActiveRecord::Base

  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#"}
  has_secure_password

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  #validates :username, length: {minimum: 3, maximum: 36}
  #validates :email, :email_format => {:message => 'incorrect email'}
  #validates :phone, length: {maximum: 10}

end
