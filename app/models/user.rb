class User < ActiveRecord::Base

  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true, length: {maximum: 50, minimum: 2}
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
  validates :phone, presence: true
  validates :gender, presence: true
  validates :password, presence: true

  # FRIENDSHIPS
  has_many :friendships
  has_many :passive_friendships, :class_name => "Friendship", :foreign_key => "friend_id"

  has_many :active_friends, -> { where(friendships: { accept: true}) }, :through => :friendships, :source => :friend
  has_many :passive_friends, -> { where(friendships: { accept: true}) }, :through => :passive_friendships, :source => :user
  has_many :pending_friends, -> { where(friendships: { accept: false}) }, :through => :friendships, :source => :friend
  has_many :requested_friendships, -> { where(friendships: { accept: false}) }, :through => :passive_friendships, :source => :user


  def friends
    active_friends | passive_friends
  end


  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#"}
  has_secure_password

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

end
