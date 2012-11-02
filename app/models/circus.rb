class Circus < ActiveRecord::Base
  attr_accessible :brother_id, :participation

  belongs_to :brother
end
