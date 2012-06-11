class User < ActiveRecord::Base
  attr_accessible :name, :password
end
