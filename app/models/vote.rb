class Vote < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
end
