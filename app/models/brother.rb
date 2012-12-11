class Brother < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  has_secure_password

  before_save :create_remember_token

  has_many :entries, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_brothers, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
           class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :beans
  has_many :entries, through: :beans
  has_many :circuses

  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  
  VALID_NAME_REGEX = /[a-z0-9]+\z/i
  validates :name, presence: true, length: {within: 3..20}, 
            format: { with: VALID_NAME_REGEX }, uniqueness: true
  
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  paginates_per 30

  def feed
    Entry.from_brothers_followed_by(self)
  end

  def following?(other_brother)
    relationships.find_by_followed_id(other_brother.id)
  end

  def follow!(other_brother)
    relationships.create!(followed_id: other_brother.id)
  end

  def unfollow!(other_brother)
    relationships.find_by_followed_id(other_brother.id).destroy
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
