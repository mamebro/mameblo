class Relationship < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  # attr_accessible :followed_id

  belongs_to :follower, class_name: "Brother"
  belongs_to :followed, class_name: "Brother"

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
