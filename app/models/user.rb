class User < ActiveRecord::Base
  attr_accessible :name, :password, :password_confirmation
  has_secure_password

  validates :name, presence: true, length: {maximam: 50}


#  VALID_NAME_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#  validates :name, presence:   true,
#                    format:     { with: VALID_NAME_REGEX },
#                    uniqueness: { case_sensitive: false }
#  validates :password, presence: true, length: { minimum: 6 }
#  validates :password_confirmation, presence: true
end
