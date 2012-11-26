class Circus < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :brother
end
