class Brother < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include Ikachan
  has_secure_password

  before_save :create_remember_token

  RESERVED_NAMES ||= YAML.load_file(Rails.root.join('config', 'reserved', 'names.yml'))['names']

  has_many :entries, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_brothers, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
           class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :circuses
  has_many :authentications, dependent: :destroy

  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  VALID_NAME_REGEX = /\A[a-z0-9]+\z/i
  validates :name,
    presence: true,
    length: {within: 3..20},
    format: { with: VALID_NAME_REGEX },
    uniqueness: true,
    exclusion: { in: RESERVED_NAMES, message: "そういう名前は名乗れないよ。" }

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

  def to_param
    name
  end

  def self.find_by_name_or_id(arg)
    find_by_name(arg) || find(arg)
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save! UserMailer.password_reset(self).deliver
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column: self[column])
  end
end
