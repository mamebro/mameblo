class Bean < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :entry
end
