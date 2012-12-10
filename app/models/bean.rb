class Bean < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :brother
  belongs_to :entry
end
