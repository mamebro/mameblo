class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password

  before_save { |user|user.email = email.downcase }  
  before_save :create_remember_token
  has_many :entries 

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  
  VALID_NAME_REGEX = /[a-z0-9]+\z/i
  validates :name, presence: true, length: {maximum: 50}, 
  format: { with: VALID_NAME_REGEX }, uniqueness: true
  
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
  end
