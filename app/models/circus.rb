class Circus < ActiveRecord::Base
  attr_accessible :brother_id, :participation

  belongs_to :brother

  scope :by_created_day, lambda { |date|
    where("#{table_name}.created_at" => date.all_day)
  }

end
